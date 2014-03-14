"use strict";

define(function(require) {
	
	var _ 		 	= require("underscore"),
		$		 	= require("jquery"),
		Backbone 	= require("backbone"),
		templ 	 	= require("text!mod/templates/tmpl_mEntry.html"),
		View_Entry 	= require("mod/views/v_mEntry"),
 	
	View_Result = Backbone.View.extend({
		
		// for deletion update
		//url: "server/server.php",
		/*
		url: function() { 
			return '/remove/' + encodeURIComponent(this.id);
		},
		*/
		
		tagName: "div",
	    className: "",
	 	template: _.template( templ ),

		initialize: function() {
			
		},

		events: {
			
		},

		render: function() {
			this.$el.html( this.template(this.model.toJSON()) );
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