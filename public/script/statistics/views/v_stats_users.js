"use strict";


define(function(require){

	var _ 				= require("underscore"),
		$ 				= require("jquery"),
		Backbone 		= require("backbone"),
		templ 			= require("text!templates/tmpl_stats_users.html"),
		View_user		= require("views/v_stats_users_user"),

	View_AppNavi = Backbone.View.extend({
		
		tagName: "div",
		
		className: "",

		templates: {
			users: _.template( templ )
		},

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
			this.listenTo(this.collections.users, "add", this.addOneUser);
		},

		addOneUser: function(user)
		{
			var person = new View_user(user);
			this.$el.append(person.render().el);
		},
			
		render: function() {
			console.log("USERS rendered");
			this.$el.html(this.templates.users());
			//this.assignHooks();
			this.addListeners();
			return this;
		},

		assignHooks: function()
		{	

		}

	});

	return View_AppNavi;

});