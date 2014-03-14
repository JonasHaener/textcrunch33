"use strict";


define(function(require){

	var _ 				= require("underscore"),
		$ 				= require("jquery"),
		Backbone 		= require("backbone"),
		templ 			= require("text!blocks/templates/tmpl_mAppNavi.html"),

	View_AppNavi = Backbone.View.extend({
		
		tagName: "div",
		
		className: "",

		template: _.template( templ ),

		events: {
			"click .js_clean_view" 		 	: "cleanView",
			"click .js_get_more_results" 	: "getMoreResults",
			"click .js_show_hide_languages" : "showHideLanguages"
		},

		collections: {
			// set by parent

		},

		router: null,

		CUSTEVENTS:
		{
			fetchBlocks	  	: "fetchBlocks",
			updateTotal   	: "updateTotalItemCount",
			actionSuccess 	: "actionSuccess",
			actionError   	: "actionError",
			inprogress    	: "inprogress",
			tagsLoaded    	: "tagsLoaded",
			moreDataToFetch : "moreDataToFetch",
			cleanView 		: "cleanView",
			hideLanguages 	: "hideLanguages"
		},

		CSS: {
			confirmMessage	: "egg-face-confirm-backgr",
			errorMessage  	: "egg-face-error-backgr",
			in_progress		: "egg-face-inprogress",
			tagsLoaded      : "egg-face-tags-loaded",
			moreData 		: "egg-face-more-data",
			cleanView       : "clean"
		},

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
			this.listenTo(this.router, this.CUSTEVENTS.updateTotal, 	this.updateTotalItemCount);
			this.listenTo(this.router, this.CUSTEVENTS.actionError, 	this.actionError);
			this.listenTo(this.router, this.CUSTEVENTS.actionSuccess, 	this.actionSuccess);
			this.listenTo(this.router, this.CUSTEVENTS.inprogress, 		this.inprogress);
			this.listenTo(this.router, this.CUSTEVENTS.tagsLoaded, 		this.tagsLoaded);
			this.listenTo(this.router, this.CUSTEVENTS.moreDataToFetch, this.notifyMoreData);
		},
			
		render: function() {
			var data = { user: window.APP.user, domain: window.APP.domain };
			this.$el.html( this.template(data) );
			this.assignHooks();
			this.addListeners();
			return this;
		},

		assignHooks: function()
		{	
			this.$notifier 		=  this.$(".js_notify_user");
			this.$inprogress 	=  this.$(".js_processing");
			this.$totalCount    =  this.$(".js_total_item_count");
			this.$getMoreResults = this.$(".js_get_more_results");
		},

		showHideLanguages: function()
		{
			this.collections.blockEntries.trigger(this.CUSTEVENTS.hideLanguages);
		},

		getMoreResults: function()
		{
			this.collections.blockEntries.trigger(this.CUSTEVENTS.fetchBlocks);
		},

		cleanView: function()
		{
			this.router.cleanView();
		},

		updateTotalItemCount: function(items)
		{
			this.$totalCount.text(items.total);	
		},

		notifyMoreData: function(flag)
		{
			if(flag.flag === true) {
				this.$getMoreResults.addClass(this.CSS.moreData);
			} else {
				this.$getMoreResults.removeClass(this.CSS.moreData);
			}
		},

		tagsLoaded: function(flag)
		{
			
			var hook = this.$inprogress,
				_this = this;

			if(flag.flag !== true && flag.flag !==  false) {
				throw "Expect boolean argument";
				return;
			}

			if(flag.flag === true) {
				hook.addClass(_this.CSS.tagsLoaded);

			} else if(flag.flag === false) {
				hook.addClass(_this.CSS.errorMessage);

			}

			// remove notifier
			setTimeout(function()
			{
				hook.removeClass(_this.CSS.tagsLoaded);
				hook.removeClass(_this.CSS.errorMessage);

			}, 500);
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
		}
	});

	return View_AppNavi;

});