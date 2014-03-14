"use strict";

define(function(require) {

	var Backbone = require("backbone"),
		// /LocalStorage = require("localStorage"),
		Model = require("mod/models/m_mCategory"),

	Collection_Categories = Backbone.Collection.extend({
		
		
		// customize this collection to accept
		// special settings to be submitted to server
		url: "/textcrunch3/application/modules/fetch_categories.php",
		model: Model

	});

	return Collection_Categories;

});	