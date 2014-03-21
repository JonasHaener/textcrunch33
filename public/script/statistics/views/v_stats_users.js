"use strict";


define(function(require){

	var _ 				= require("underscore"),
		$ 				= require("jquery"),
		Backbone 		= require("backbone"),
		templ 			= require("text!templates/tmpl_stats_users.html"),
		View_user		= require("views/v_stats_users_user"),

	View_AppNavi = Backbone.View.extend({
		
		tagName: "div",
		
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
			getStats: "getStats"
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
			this.listenTo(this.collections.users, "reset", function(e, options) { 
				this.cleanUp(e, options);
			});
			
// test disabled			this.listenTo(this.router, this.CUSTEVENTS.getStats, this.getUserStats);
		},

		addOneUser: function(user)
		{
			var person = new View_user({ model : user });
			this.$(".js_stats_users").append(person.render().el);
		},
			
		render: function() {
			this.$el.html(this.templates.users());
			//this.assignHooks();
			this.addListeners();
			return this;
		},

		assignHooks: function()
		{	

		},

		cleanUp: function(e, options)
		{
			if(!options.previousModels) { return; };
			options.previousModels.forEach(function(model, index){
				model.trigger("cleanup");
			});

		},

		fetchEntries: function(collection, configs)
		{
			this.router.inprogress(true);
			collection.fetch(configs);
		},

		getUserStats: function()
		{
			
			this.collections.users.reset();

			var _this = this,

				configs = {
				
				data: { users_stats : true },

				success: function(collection, response, options)
				{
					if(response.length > 0) {
						// if no records are found GET HTTP response is 204 -> no error
						_this.router.actionSuccess();
					
					} else {
						_this.router.actionError();
					}
					
					// remove progress bar
					_this.router.inprogress(false);

				},
				
				error: function(collection, response, options)
				{
					// alert error
					_this.router.actionError();
					// remove progress bar
					_this.router.inprogress(false);
				}
				
			};
			
			// fetch blocks
			this.fetchEntries(this.collections.users, configs);
		}

	});

	return View_AppNavi;

});