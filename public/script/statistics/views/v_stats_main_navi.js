"use strict";


define(function(require){

	var _ 				= require("underscore"),
		$ 				= require("jquery"),
		Backbone 		= require("backbone"),
		templ 			= require("text!templates/tmpl_stats_main_navi.html"),

	View_AppNavi = Backbone.View.extend({
		
		tagName: "div",
		
		className: "",

		template: _.template( templ ),

		events: {
			"click .js_get_stats" 		 	: "getStats",
			//"click .js_get_more_results" 	: "getMoreResults",
			//"click .js_show_hide_languages" : "showHideLanguages"
		},

		collections: {
			// set by parent

		},

		router: null,

		CUSTEVENTS:
		{
			actionSuccess 	: "actionSuccess",
			actionError   	: "actionError",
			inprogress    	: "inprogress",
			getStats 		: "getStats"
		},

		CSS: {
			confirmMessage	: "egg-face-anim-notify-success",
			errorMessage  	: "egg-face-error-backgr",
			in_progress		: "egg-face-inprogress",
		},

		assignHooks: function()
		{	
			this.$notifier 		=  this.$(".js_notify_user");
			this.$inprogress 	=  this.$(".js_processing");
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
			this.listenTo(this.router, this.CUSTEVENTS.actionError, 	this.actionError);
			this.listenTo(this.router, this.CUSTEVENTS.actionSuccess, 	this.actionSuccess);
			this.listenTo(this.router, this.CUSTEVENTS.inprogress, 		this.inprogress);
		},
			
		render: function() {
			this.$el.html( this.template() );
			this.assignHooks();
			this.addListeners();
			return this;
		},

		inprogress: function(flag) {
			
			if(flag.flag !== true && flag.flag !==  false) {
				throw "Expect boolean argument";
				return;
			}

			if(flag.flag === true) {
				this.$inprogress.addClass(this.CSS.in_progress);

			} else if(flag.flag === false) {
				this.$inprogress.removeClass(this.CSS.in_progress);
			}
		},

		actionSuccess: function()
		{
			var hook = this.$notifier,
				_this = this;

			hook.addClass(_this.CSS.confirmMessage);
			setTimeout(function()
			{
				hook.removeClass(_this.CSS.confirmMessage);
			}, 600);
		},

		actionError: function()
		{
			var hook = this.$notifier,
				_this = this;

			hook.addClass(_this.CSS.errorMessage);
			setTimeout(function()
			{
				hook.removeClass(_this.CSS.errorMessage);
			}, 1000);
		},

		getStats: function() {
			this.router.trigger(this.CUSTEVENTS.getStats);
		}

	});

	return View_AppNavi;

});