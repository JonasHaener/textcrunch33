"use strict";

define(function(require) {
	
	var Backbone = require("backbone"),
		messages = require("messages/messages"),
		

	Model = Backbone.Model.extend({
		
		idAttribute : "user_id",
		
		defaults: {
	        tags		: null,
	        blocks		: null,
	        categories	: null

	        /* JSON format needed
	        tags: {
	        	total: 0,
	        	total_unused: 0,
	        	unused_listed: ""
	        },
	        blocks: {
				total: 0,
				average_tags: 0
	        },
	        categories: {
				name: "",
				blocks: 0
	        }
	        */

		},

		initialize: function()
		{
			this.on("invalid", function(model, error)
			{

			});

		},

		validate: function(attrs)
		{

		}		
	});

	return Model;

});	