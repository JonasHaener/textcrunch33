"use strict";

define(function(require) {

	var Backbone = require("backbone"),
		// /LocalStorage = require("localStorage"),
		Model = require("blocks/models/m_mProjects"),

	Collection = Backbone.Collection.extend({
		
		url: "/textcrunch33/application/project.php",
		model: Model

	});

	return Collection;

});	