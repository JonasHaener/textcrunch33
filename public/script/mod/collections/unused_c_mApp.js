/* Backbone chield views management */
"use strict";

define(function(require) {

	var	_ 				= require("underscore"),
		$ 				= require("jquery"),	
		Backbone 		= require("backbone"),
		View_model 		= require("mod/_person/views/view_model"),
		View_appChild1 	= require("mod/_person/views/view_app_sub_1"),
		Collection 		= require("mod/_person/collections/collection"),
		Model 			= require("mod/_person/models/model");

	// App view
	var View_app = Backbone.View.extend({
		el: "#parent_view",
		
		$container: $('#parent_view_cont'),

		events: {
			"keypress .js-inp-firstname" : "createOnEnter",
			"keypress .js-inp-lastname" : "createOnEnter"
		},
		
		initialize: function() {
			// holds all sub views
			this.children = {};
			// childview 1
			this.child = new View_appChild1();
			this.collection = new Collection();
			this.children[this.child.cid] = this.child;
			this.render();

			this.listenTo(this.child, "changeColor", this.changeColor);
			this.listenTo(this.collection, "add", this.addOne);
			this.listenTo(this.collection, "reset", this.getAll);
			this.listenTo(this.collection, "all", this.console);

			// fetch instances
			this.collection.fetch();
		},

		getChildViews: function() {
			// create fragment
			var docFrag = document.createDocumentFragment();
			// loop all child views and create placeholder with "data-view-cid"
			_.each(this.children, function(view, cid) {
				var ele = document.createElement('div');
				ele.setAttribute('data-view-cid', cid);
				docFrag.appendChild(ele);
			});
			// return to rendereds
			return docFrag;
		},
		
		render: function() {
			//append child views to DOM
			this.$el.append( this.getChildViews() );
			// assign views according to their cid placeholders
			_.each(this.children, function(view, cid) {
				this.$('[data-view-cid="' + cid + '"]').replaceWith(view.render().el);
			}, this);

		},

		console: function(e) {
			console.log(e);
		},	

		addOne: function(person) {
			console.log(person);
			var v = new View_model( { model: person } );
			this.$container.append( v.render().el );
		},

		getAll: function() {
			//this.$container.html("");
			this.collection.each(this.addOne, this);
		},
		
		getAttr: function() {
			var inpFirstName = $('.js-inp-firstname').val().trim(),
				inpLastName = $('.js-inp-lastname').val().trim(),
				inpLikes =	$('.js-inp-likes').val().trim();
			
			if (inpLastName === "") {
				return false;
			}
									
			return {
				firstname: inpFirstName,
				lastname: inpLastName,
				likes: inpLikes 
			};
		},
		
		clearInput: function() {
			$('js-inp-firstname').val("");
			$('js-inp-lastname').val("");
		},
		
		createOnEnter: function(e) {
			if(e.which === 13) {
				var inp = this.getAttr();
				if(inp !== false) {
					this.collection.create( this.getAttr() );
					this.clearInput();	
				}
			}
		},

		changeColor: function() {
			console.log('change color called from parent view');
			this.$('.item').toggleClass('newColor');
		}

	});

	return View_app;

});