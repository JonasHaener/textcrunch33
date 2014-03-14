"use strict";

define(function(require) {

	var Backbone = require("backbone"),
		// /LocalStorage = require("localStorage"),
		Model = require("models/m_mEntry"),

	Collection = Backbone.Collection.extend({
		
		url: "/textcrunch33/application/create_entry.php",
		model: Model

	});

	return Collection;

});	