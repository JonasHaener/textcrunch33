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
			"mouseover .js_to_top a" 	: "scrollToTop",
			"mouseleave .js_to_top a" 	: "scrollToTop",
			"click .js_speed_fast"		: "scrollToTop",
			"click .js_speed_slow"		: "scrollToTop"

		},
		
		initialize: function() {
			
		},

		// cleanup Events view
		onClose: function()
		{
			console.log("cleanup runs in view onClose");
			window.removeEventListener("resize", this.setToTop);
		},
			
		render: function() {
			this.$el.html( this.template({ year: window.APP.year }) );
			this.activateWindowResize();
			return this;
		},

		activateWindowResize: function()
		{
			window.addEventListener("resize", this.setToTop, false);
			this.setToTop();
		},

		setToTop: function(e)
		{
			var left = $("#js_col_left").offset().left-30 + "px";
				//top = window.innerHeight-200 + "px";

			this.$(".js_to_top").css({
				//"top"	: top,
				"left"	: left
			});

		},

		scrollToTop: function(e)
		{
			var self = this.scrollToTop,
				scrollTop = document.body.scrollTop;
			
			if(e && e.type === "click") {
				
				var speed = $(e.currentTarget).attr("data-speed");
				
				if(speed) {
					this.$("[data-speed]").removeClass("speed-is-set");
					$(e.currentTarget).addClass("speed-is-set");
					// set scroll speed
					this.scrollSpeed = speed;
				}
			}				

			if(e && e.type === "mouseleave") {
				this.scrolling = false;
			}


			if(e && e.type === "mouseover") {
				this.scrolling = true;
			}


			if(this.scrolling === true) {
				if(scrollTop > 0) {
					// scroll speed adjust number of pixels scrolled
					// if scroll speed has not been set by user assign 5 pixels per function call
					document.body.scrollTop = scrollTop - (this.scrollSpeed||5);
					setTimeout(function() {
						this.scrollToTop();
					}.bind(this), 50);
				}
			}
		}
	});

	return View_Footer;

});