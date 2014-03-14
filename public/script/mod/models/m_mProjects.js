"use strict";

define(function(require) {
	
	var Backbone = require("backbone"),
		messages = require("mod/messages/messages"),
		

	Model_Projects = Backbone.Model.extend({
		
		idAttribute : "project_id",
		
		defaults: {
	        // remove id, only for testing
	        // id supplied by Backbone
	        project_name	: "",
	        collection		: ""
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
			if(attrs.project_name === "" && attrs.collection === "")
			{
				return messages.model_projects_missingIdentifier;
			}
		}

	});

	return Model_Projects;

});	