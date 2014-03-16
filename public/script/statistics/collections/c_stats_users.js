"use strict";

define(function(require) {

	var Backbone = require("backbone"),
		// /LocalStorage = require("localStorage"),
		Model = require("models/m_stats_user"),

	Collection_Users = Backbone.Collection.extend({
		// customize this collection to accept
		// special settings to be submitted to server
		url: "/textcrunch33/application/stats.php",
		model: Model,

	});

	return Collection_Users;

});	