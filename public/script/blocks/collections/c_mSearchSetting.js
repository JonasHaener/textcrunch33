"use strict";

define(function(require) {

	var Backbone = require("backbone"),
		// /LocalStorage = require("localStorage"),
		Model = require("blocks/models/m_mEntry"),

	Collection_Search = Backbone.Collection.extend({
		
		
		// customize this collection to accept
		// special settings to be submitted to server
		url: "/textcrunch33/application/search.php",
		model: Model

	});

	return Collection_Search;

});	