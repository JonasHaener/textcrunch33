"use strict";

define(function(require) {
	
	var Backbone = require("backbone"),
		messages = require("messages/messages"),
		

	Model = Backbone.Model.extend({
		
		idAttribute : "user_id",
		
		defaults: {
	        username		: "",
	        rights_name		: "",
	        projects		: "",
	        blocks_created	: "",
	        blocks_deleted	: "",
	        last_login		: ""
		
		}

	});

	return Model;

});	