"use strict";


define(function(require){

	var _ 				= require("underscore"),
		$ 				= require("jquery"),
		Backbone 		= require("backbone"),
		templ 			= require("text!templates/tmpl_stats_categories.html"),
		templ_cats 		= require("text!templates/tmpl_stats_categories_cat.html"),

	View_AppNavi = Backbone.View.extend({
		
		tagName: "div",
		
		className: "",

		templates:  {
			categories: _.template( templ ),
			cats	  : _.template( templ_cats ),
		},

		hooks:{},

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
			this.listenTo(this.collections.other, "add", this.addStats);
		},
			
		render: function() {
			this.$el.html( this.templates.categories() );
			this.assignHooks();
			this.addListeners();
			return this;
		},

		assignHooks: function()
		{	
			this.hooks.cats = this.$(".js_categories")
		},

		addStats: function(model)
		{
			//var cats = (stats) ? stats.cats.toJSON() : {};
			if(!model) { return; }
			var categories = {};
			model = model.toJSON().categories;
			_.each(model, function(blocks, index, list) {
				categories[index] = {};
				categories[index].name = index;
				categories[index].blocks = blocks;
			});
			this.hooks.cats.html(this.templates.cats({ cats: categories }));
		}

	});

	return View_AppNavi;

});