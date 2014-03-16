"use strict";


define(function(require){

	var _ 				= require("underscore"),
		$ 				= require("jquery"),
		Backbone 		= require("backbone"),
		templ 			= require("text!templates/tmpl_stats_users_user.html"),

	View_AppNavi = Backbone.View.extend({
		
		tagName: "tr",
		
		templates: {
			user:  _.template( templ )
		},
		
		/*
		events: {
		
		},

		router: null,

		
		CUSTEVENTS:
		{

		},

		CSS: {

		},
		*/

		initialize: function() {
			// remove views when models are destroyed
			this.listenTo(this.model, "cleanup", this.close);
		},

		// cleanup Events view
		onClose: function()
		{
			console.log("cleanup runs in view onClose");
			this.collections = this.router = null;
		},

		render: function() {
			
			this.$el.html(this.templates.user(this.model.toJSON()));
			//this.assignHooks();
			//this.addListeners();
			return this;
		},

		/*
		assignHooks: function()
		{	

		},

		addListeners: function()
		{
			
		}
		*/

	});

	return View_AppNavi;

});