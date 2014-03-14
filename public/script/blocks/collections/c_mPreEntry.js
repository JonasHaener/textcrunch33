"use strict";

define(function(require) {

	var Backbone = require("backbone"),
		// /LocalStorage = require("localStorage"),
		Model = require("blocks/models/m_mPreEntry"),

	Collection = Backbone.Collection.extend({
		
		url: "/textcrunch33/application/search.php",
		
		model: Model,

	});

	return Collection;

});	