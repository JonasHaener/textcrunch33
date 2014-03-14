"use strict";

define(function(require) {
	
	var Backbone = require("backbone"),

	Model = Backbone.Model.extend({
		
		idAttribute : "block_id",

		//url: "/textcrunch33/application/search.php",
		
		defaults: {
		}

	});

	return Model;

});	