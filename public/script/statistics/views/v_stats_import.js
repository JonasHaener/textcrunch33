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
			this.hooks.uploadProgress = this.$(".js_drop_progress");
			this.hooks.showFileSize = this.$(".js_drop_file_size");
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

		/* function for displaying a percentage progress bar
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
		*/

		calcFilesize: function(bytes, unit)
		{
			// 1MB = bytes / pwr(1024, 2)
			// 1KB = 1024 bytes
			var conv;
			switch(unit) {
				case "KB":
					conv = 1024;
					break;
				case "MB":
					conv = Math.pow(1024, 2);
					break;
				default:
					conv = 0;		
			}

			return (bytes/conv).toFixed(2);
		},

		updateStatus: function(status) 
		{
			// show file size
			this.hooks.uploadProgress.text(status);
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

            // indicate progress	
			self.router.inprogress(true);
			
			// display the file size
			self.hooks.showFileSize.text( self.calcFilesize(file.size, "KB") + "KB" );
            
            // create XHR object
            xhr.open("POST", uri, true);

            // receive response
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

	                	self.updateStatus("Created " + res.created + " entries");	
	                	
						// remove progress bar
						// reset default text
						setTimeout(function() {
							self.updateStatus(placeholder);
							self.hooks.showFileSize.text("");					
						}, 2500);	
                    
                    // ERROR
                    } else {
						self.router.actionError();
						// load failed
						//self.updatePerc(0, true);
						// reset default text
						setTimeout(function() {
							self.updateStatus(placeholder);
							self.hooks.showFileSize.text("");					
						}, 1000);
                	}
                }
            };

            
            xhr.upload.addEventListener("progress", function(e) {

				if(e.lengthComputable) {
					var percCompl = (e.loaded / e.total)*100;
					// add file size info
					self.updateStatus(percCompl+"%");
				
				}
			}, false);


			xhr.upload.addEventListener("load", function(e) {
				// 100% loaded
				self.updateStatus("100%");
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