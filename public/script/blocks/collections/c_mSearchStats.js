"use strict";

define(function(require) {
	
	var _ 		 = require("underscore"),
		$		 = require("jquery"),
		Backbone = require("backbone"),
		templ	 = require("text!  person/templates/templ_model.html"),
 	
	View_model = Backbone.View.extend({
		
		// for deletion update
		//url: "server/server.php",
		/*
		url: function() { 
			return '/remove/' + encodeURIComponent(this.id);
		},
		*/
		
		tagName: "div",
	    className: 'item',
	 	template: _.template( templ ),

		initialize: function() {
			this.listenTo(this.model, "change", this.render);
		},

		events: {
			"click .js_delete_item"		: "delete",
			"dblclick .js_item_input" 	: "edit",
			"blur .js_item_input" 		: "close"
		},

		render: function() {
			this.$el.html( this.template(this.model.toJSON()) );
			if(!this.$input) {
				this.$input = this.$('.js_item_input');
			}
			return this;	
		},

		edit: function() {
			console.log('editor runs');
			//this.$input.prop('disabled', false);
		},

		validateInp: function(inp) {
			return inp !== "";
		},

		close: function() {
			var inpFirstName 	= $('.js-md-firstname').val().trim(),
				inpLastName 	= $('.js-md-lastname').val().trim(),
				inpLikes 		= $('.js-md-likes').val().trim();


			if( this.validateInp() === true) {
				this.model.save({ 
						firstname: inpFirstName,
						lastname: inpLastName,
						likes: inpLikes
				});
			}
			this.$input.prop('disabled', "disabled");
		},

		'delete': function() {
			//destroy model
			this.model.destroy();
			// remove view from DOM
			this.$el.remove();
		}

	});

	return View_model;

});	