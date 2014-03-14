"use strict";

define(function(require) {

	var Backbone = require("backbone"),
		// /LocalStorage = require("localStorage"),
		Model = require("mod/models/m_mCatsAndTags"),

	Collection_CatsAndTags = Backbone.Collection.extend({
		// customize this collection to accept
		// special settings to be submitted to server
		url: "/textcrunch33/application/fetch_tags_and_cats.php",
		model: Model

	});

	return Collection_CatsAndTags;

});	