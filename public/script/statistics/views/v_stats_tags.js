"use strict";


define(function(require){

	var _ 				= require("underscore"),
		$ 				= require("jquery"),
		Backbone 		= require("backbone"),
		templ 			= require("text!templates/tmpl_stats_tags.html"),

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
			//var tags = (stats) ? stats.tags.toJSON() : {};
			//if(stats) {
				// remove listeners if any
		  		//this.unbind();
		  		// remove event handlers and listeners
		  		//this.stopListening();
		  		//this.addListeners();
			//}

			this.$el.html( this.template() );
			this.assignHooks();
			this.addListeners();
			return this;
		},

		assignHooks: function()
		{	
			this.hooks.total		 = this.$("js_tag_stats_total");
			this.hooks.unused 		 = this.$("js_tag_stats_unused");
			this.hooks.unused_listed = this.$("js_tag_stats_unused_listed");
		},

		addStats: function(data)
		{
			if(!data) { return; }
			this.hooks.total.text(data.total);
			this.hooks.unused.text(data.total_unused);
			this.hooks.unused_listed.text(data.unused_listed);
		}

	});

	return View_AppNavi;

});