"use strict";


define(function(require){

	var _ 				= require("underscore"),
		$ 				= require("jquery"),
		Backbone 		= require("backbone"),
		templ 			= require("text!templates/tmpl_stats_import.html"),

	View_AppNavi = Backbone.View.extend({
		
		tagName: "div",
		
		className: "",

		template: _.template( templ ),

		events: {
			"drop .js_dropbox"         : "uploadFile",
			"dragover .js_drop_here"   : "addDropBoxMarking",
			"dragleave .js_drop_here"  : "addDropBoxMarking",
			//"click .js_submit"		   : "uploadFile",
			//"submit form"				: function(e) {
			//	e.preventDefault();
			//	this.uploadFile(e);
			//}
		},

		collections: {

		},

		router: null,

		CUSTEVENTS:
		{

		},

		CSS: {
			hide: "egg-is-hidden",
			dragOver: "egg-is-drop-over"
		},

		hooks: {},

		timer: null,

		initialize: function() {
			
		},

		// cleanup Events view
		onClose: function()
		{
			console.log("cleanup runs in view onClose");
			this.collections = this.router = null;
		},

		setForeignCollection: function(collection)
		{
			var i;
			for(i in collection)
			{
				this.collections[i] = collection[i];
			}
		},

		addListeners: function()
		{

		},
			
		render: function() {
			this.$el.html( this.template() );
			this.assignHooks();
			this.addListeners();
			return this;
		},

		assignHooks: function()
		{	
			this.hooks.dropbox = this.$(".js_dropbox");
			this.hooks.dropHere = this.$(".js_drop_here");
			this.hooks.uploadProgress = this.$(".js_upload_progress");
		},

		addDropBoxMarking: function(e)
		{
			var _this = this;
			// create temp object
			if(e.preventDefault && e.stopPropagation) {
				e.preventDefault();
				e.stopPropagation();
			}

			if(e.type === "dragover") {
				// if timer runs exit
				if(this.timer) { return; }
				this.hooks.dropHere.addClass(_this.CSS.dragOver);
				this.timer = setTimeout(function() {
			 		_this.timer = null;
				}, 1000);
			}
			
			if(e.type === "dragleave") {
			 	this.hooks.dropHere.removeClass(_this.CSS.dragOver);
			 	this.timer = null;
			}
		},

		updatePerc: function(value, remove) {
			var perc = value + "%",
				_this = this;
			
			this.hooks.uploadProgress
				.parent().removeClass(this.CSS.hide)
				.end()
				.css("width", perc)
				.text(perc);
			
			if(remove === true) {
				setTimeout(function() {
					_this.hooks.uploadProgress	
						.parent().addClass(_this.CSS.hide)
						.end()
						.css("width", "5%")
						.text("0%");
				}, 1000);
			}
		},

		updateFileSize: function(file) {
			// 1MB = bytes / pwr(1024, 2)
			// 1KB = 1024 bytes
			var conv_MB = Math.pow(1024, 2),
				conv_KB = 1024,
				MBytes = (file.size/conv_KB).toFixed(2);

			this.hooks.dropHere.text(MBytes+"KB");

		},

		uploadFile: function(e)
		{
			e.preventDefault();
			e.stopPropagation();
            
            var self = this,
            	file = e.originalEvent.dataTransfer.files[0],
            	fileName = file.name,
            	placeholder = this.hooks.dropHere.text(),
            	uri = "/textcrunch33/application/import.php",
            	xhr = new XMLHttpRequest(),
            	fd = new FormData();

			this.updateFileSize(file);

			this.router.inprogress(true);
            
            xhr.open("POST", uri, true);

            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4) {
                    
                    // OK
                    if(xhr.status === 200 || xhr.status === 204) {
	                	// notify user of saved
	                	var res = JSON.parse(xhr.response);
	                	
	                	if(res.created < 1) {
	                		self.router.actionError();
	                	
	                	} else {
							self.router.actionSuccess();
	                	}

	                	self.hooks.dropHere.text("Created " + res.created + " entries.");	
	                	
						// remove progress bar
						// reset default text
						setTimeout(function() {
							self.hooks.dropHere.text(placeholder);					
						}, 2500);	
                    
                    // ERROR
                    } else {
						self.router.actionError();
						// load failed
						self.updatePerc(0, true);
						// reset default text
						setTimeout(function() {
							self.hooks.dropHere.text(placeholder);					
						}, 1000);
                	}
                }

            };

            
            xhr.upload.addEventListener("progress", function(e) {
				if(e.lengthComputable) {
					var percCompl = (e.loaded / e.total)*100;
					self.updatePerc(percCompl, false);
				}	
			}, false);


			xhr.upload.addEventListener("load", function(e) {
				// 100% loaded
				self.updatePerc(100, true);
			}, false);


            fd.append('import', file);
            // Initiate a multipart/form-data upload
            xhr.send(fd);

            // remove drop box marking
            this.addDropBoxMarking({ type: "dragleave" });

        }

	});

	return View_AppNavi;

});