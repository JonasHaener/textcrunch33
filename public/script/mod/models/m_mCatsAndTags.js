"use strict";

define(function(require) {
	
	var Backbone = require("backbone"),
		messages = require("mod/messages/messages"),
		

	Model = Backbone.Model.extend({
		
		idAttribute : "cat_id",
		
		defaults: {
	        id: 0,
	        categories: [],
	        tags: []
		},

		initialize: function()
		{
			this.on("invalid", function(model, error)
			{
				alert( error );
			});

		},

		validate: function(attrs)
		{
			
			if(attrs.category.length <= 0)
			{
				return messages.model_categ_missing;
			}

		}
	});

	return Model;

});	