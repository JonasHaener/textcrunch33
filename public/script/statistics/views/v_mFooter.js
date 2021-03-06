"use strict";


define(function(require){

	var _ 				= require("underscore"),
		$ 				= require("jquery"),
		Backbone 		= require("backbone"),
		templ 			= require("text!templates/tmpl_mFooter.html"),

	View_Footer = Backbone.View.extend({
		tagName: "div",
		className: "",

		template: _.template( templ ),

		events: {

		},
		
		initialize: function() {
			
		},
			
		render: function() {
			this.$el.html( this.template({ year: window.APP.year }) );
			return this;
		},

		// cleanup Events view
		onClose: function()
		{
			console.log("cleanup runs in view onClose");
		}

	});

	return View_Footer;

});