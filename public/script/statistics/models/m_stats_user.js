"use strict";

define(function(require) {
	
	var Backbone = require("backbone"),
		messages = require("messages/messages"),
		

	Model = Backbone.Model.extend({
		
		idAttribute : "user_id",
		
		defaults: {
	        username		: "",
	        rights_name		: "",
	        projects		: 0,
	        blocks_created	: 0,
	        blocks_deleted	: 0,
	        last_login		: ""


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