"use strict";


define(function(require){

	var _ 				= require("underscore"),
		$ 				= require("jquery"),
		Backbone 		= require("backbone"),
		templ 			= require("text!templates/tmpl_stats_blocks.html"),

	View_AppNavi = Backbone.View.extend({
		
		tagName: "div",
		
		className: "",

		template: _.template( templ ),

		events: {
		
		},

		collections: {

		},

		router: null,

		CUSTEVENTS:
		{

		},

		CSS: {

		},

		hooks: {},

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
			this.listenTo(this.collections.other, "add", this.addStats)
		},
			
		render: function(stats) {
			// stats is available when data is fetched from DB
			// on first render no stats
			//var blocks = (stats) ? stats.blocks.toJSON() : {};
			//if(stats) {
				// remove listeners if any
		  	//	this.unbind();
		  		// remove event handlers and listeners
		  	//	this.stopListening();
			//}
			this.$el.html( this.template() );
			this.assignHooks();
			this.addListeners();
			return this;
		},

		assignHooks: function()
		{	
			this.hooks.total		 = this.$(".js_block_stats_total");
			this.hooks.averageTags	 = this.$(".js_block_stats_average_tags");
		},

		addStats: function(data)
		{
			if(!data) { return; }
			data = data.toJSON().blocks;
			this.hooks.total.text(data.total);
			this.hooks.averageTags.text(data.average_tags);
		}
	});

	return View_AppNavi;

});