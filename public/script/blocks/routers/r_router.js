"use strict";

define(function(require) {
	
	var _ 		 = require("underscore"),
		$		 = require("jquery"),
		Backbone = require("backbone"),


	// ## Currently only use to relay messages
	// to user behaviour	
 	
	Router = Backbone.Router.extend({

  		routes: {
 	
 		},

		CUSTEVENTS:
		{
			// total number of entries
			updateTotal   	: "updateTotalItemCount",
			// action succeed alert user
			actionSuccess 	: "actionSuccess",
			// action failed alert user
			actionError   	: "actionError",
			// action is in progress and not done
			inprogress    	: "inprogress",
			// tags and categories are loaded
			tagsLoaded    	: "tagsLoaded",
			// more data to be fetched if more than
			// set items per fetch are available
			moreDataToFetch : "moreDataToFetch",
			// cleans results content view to only
			// show text content
			cleanView       : "cleanView"
		},

		initialize: function()
		{

		},

		actionSuccess: function()
		{
			this.trigger(this.CUSTEVENTS.actionSuccess);
		},

		actionError: function()
		{
			this.trigger(this.CUSTEVENTS.actionError);
		},

		inprogress: function(flag)
		{
			this.trigger(this.CUSTEVENTS.inprogress, { flag: flag });
		},

		tagsLoaded: function(flag)
		{
			this.trigger(this.CUSTEVENTS.tagsLoaded, { flag: flag });			
		},

		notifyMoreData: function(flag)
		{
			this.trigger(this.CUSTEVENTS.moreDataToFetch, { flag: flag });
		},

		updateTotal: function(total)
		{
			this.trigger(this.CUSTEVENTS.updateTotal, { total: total });
		},

		cleanView: function()
		{
			this.trigger(this.CUSTEVENTS.cleanView);
		}	

	});

	return Router;

});	