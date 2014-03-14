// Loads scripts

"use strict";

require.config({

	// script root directory
	baseUrl: "script",
	// paths for libs
	paths: {
		"underscore"	: "libs/underscore",
		"backbone" 		: "libs/backbone",
		"jquery" 		: "libs/jquery",
		"localStorage"	: "libs/backbone_localStorage",
		"text"			: "require/text",
		"bootstrap"     : "libs/bootstrap.min",

	},
	// shims for non-AMD supported libs
	shim: {
		"underscore": {
			exports: "_"
		},
		"backbone": {
			deps: ["underscore", "jquery"],
			exports: "Backbone"
		},
		"localStorage": {
			deps: ["underscore", "jquery"],
			exports: "LocalStorage"
		},
		"bootstrap": {
			deps: ["jquery"],
			exports: "Bootstrap"
		}
	}

});	


require(["jquery", "backbone", "mod/views/v_mApp"], function($, Backbone, View_app ) {

	// Custom Backbone settings
	Backbone.View.prototype.close = function(){
  		console.log("Backbone prototype close runs");
  		// remove custom event listeners
  		this.unbind();
  		// remove event handlers and listeners
  		this.stopListening();
  		if (this.onClose) {
    		this.onClose();
  		}
		// remove from DOM
		this.remove();
	}

	var appView  = new View_app();
	// Document ready
	$(function() {
		// render main navigation
		appView.render();
	});

	window.addEventListener("beforeunload", function() {
		// cleanup event handlers;
		console.log("Unloaded, see you!");
		appView.cleanUp();
	}, false);	

});

