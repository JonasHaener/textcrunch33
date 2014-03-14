"use strict";

define(function(require) {
	
	var Backbone = require("backbone"),
		messages = require("blocks/messages/messages"),
		

	Model = Backbone.Model.extend({
		
		idAttribute : "block_id",

		//url: "/textcrunch33/application/search.php",
		
		defaults: {
	        hidden			: false,
	        category		: "",
	        tags 			: [],
	        lang_to_update	: [],
	        //searchGerman	: false,
	        //searchEnglish	: false,
	        //searchAllLang	: false,
	       // searchReplaceResults: false,
	        german 			: "",
	        english 		: "",
	        french 			: "",
	        dutch 			: "",
	        italian 		: "",
	        polish 			: "",
	        spanish 		: "",
	        japanese		: ""
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
			
			if(attrs.category === "")
			{
				return messages.model_categ_missing;
			}
			if(attrs.tags.length <= 0)
			{
				return messages.model_tag_missing;
			}
			if(attrs.german === "")
			{
				return messages.model_german_missing;
			}
		},

		hide: function()
		{
			this.attributes.hidden = !this.attributes.hidden;
		},

		switchToInPoject: function()
		{
			this.attributes.inProject = true;
		},

		switchToNotInProject: function()
		{
			this.attributes.inProject = false;
		},		



	});

	return Model;

});	