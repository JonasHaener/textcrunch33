"use strict";


define(function(require){

	var _ 				= require("underscore"),
		$ 				= require("jquery"),
		Backbone 		= require("backbone"),
		templ_block		= require("text!mod/templates/tmpl_mResults.html"),
		templ_tagList	= require("text!mod/templates/tmpl_option_tag.html"),
		templ_catList	= require("text!mod/templates/tmpl_option_cat.html"),
		View_Entry		= require("mod/views/v_mEntry"),
		bootstrap 		= require("bootstrap"),

	View_Results = Backbone.View.extend({
		
		tagName: "div",
		
		collection : null, // from search module

		template_block		: _.template( templ_block ),
		template_tagList	: _.template( templ_tagList ),
		template_catList	: _.template( templ_catList ),

		events: {
			"focusin .js_pick_category" : "refreshTags",
			"focusin .js_pick_tag"		: "refreshTags"
		},

		CUSTEVENTS: 
		{
			hideLanguages 		: "hideLanguages",
			tagsAndCatsLoaded 	: "tagsAndCatsLoaded",
			refreshTags 	    : "refreshTags",
			cleanView           : "cleanView"
		},

		CSS: {
			clean         : "clean",
			hidden 		  : "egg-is-hidden-anim",
			// hasBadgeCount is dummy class
			hasBadgeCount : "has-count"
		},
		
		initialize: function() {

		},

		addListeners: function()
		{
			this.listenTo(this.collections.blockEntries, "success", this.success);
			this.listenTo(this.collections.blockEntries, "add", this.addOne);
			this.listenTo(this.collections.blockEntries, "remove", this.updateBadgeCount);
			// destroy is fired when the views are hidden but not removed from database
			this.listenTo(this.collections.blockEntries, "destroy", this.updateBadgeCount);
			this.listenTo(this.collections.blockEntries, "reset", function(e, options) { 
				console.log("RESET NOW");
				// remove handlers from views
				this.cleanUp(e, options);
				// rerender the newly fetched models (-> no add event on "reset")
				this.addAll();
				// reset batch count
				this.updateBadgeCount();
			});
			this.listenTo(this.collections.blockEntries, this.CUSTEVENTS.hideLanguages, this.hideLanguages);
			this.listenTo(this.collections.catsAndTags, this.CUSTEVENTS.tagsAndCatsLoaded, this.addTagsAndCats);
			this.listenTo(this.collections.catsAndTags, this.CUSTEVENTS.tagsAndCatsLoaded, this.addTagsAndCats);
			// clean results view items
			this.listenTo(this.router, this.CUSTEVENTS.cleanView, this.cleanView);
		},

		collections: 
		{
			blockEntries : null,
			catsAndTags  : null
		},

		cleanUp: function(e, options)
		{
			console.log("cleaning up old models");
			if(!options.previousModels) { return; };
			options.previousModels.forEach(function(model, index){
				model.trigger("cleanup");
			});

		},

		// cleanup Events view
		onClose: function()
		{
			console.log("cleanup runs in view onClose");
			// already on prototype but to call it separately added here again
			this.router = this.collections = null;
		},

		setForeignCollection: function(collection)
		{
			var i;
			for(i in collection)
			{
				this.collections[i] = collection[i];
			}
		},
			
		render: function() {
			this.$el.html( this.template_block() );
			this.addListeners();
			this.activateTabbedContent();
			return this;
		},

		hideLanguages: function()
		{
			var classHidden = this.CSS.hidden,
				$ele = this.$(".js_languages").find('[data-language]').not("[data-language=german], [data-language=english]");
			
			$ele.each(function() {
				$(this).toggleClass(classHidden);
			});
		},

		addAll: function() {
			var _this = this;
			this.collections.blockEntries.each(function(block, index, list) {
				_this.addOne(block);
			});
		},

		addOne: function(blockEntry)
		{
			// entry contains a category
			// which shall be inserted into the DOM accordingly
			var entry = new View_Entry({ model: blockEntry }),
				category = entry.category,
				entriesWithThisCategory = null,
				catLength = 0;
			// assign parent to get access to router and collection
			entry.parent = this;

			this.$(".js_tabbed_content_results")
				.find("[data-category=" + category + "]")
				.append( entry.render().$el );

			this.updateBadgeCount(blockEntry);
		},

		updateBadgeCount: function(entry)
		{
			// add categories count
			// to tabbed navigation
			var category,
				cats = {},
				total = 0;
			
			// this step resets all to "0"
			// because not all categories are looped
			// otherwise badge is not reset when no category item is available
			this.$(".js_tabbed_content_navi")
				.find("[data-category]")
				.removeClass(this.CSS.hasBadgeCount)
				.text("0");

			// collect all categories from collection
			this.collections.blockEntries.each(function(model, i) {
				var category = model.get("category");
				// update total
				total += 1;
				// split category count
				if(category in cats) {
					cats[category] += 1;
				
				} else {
					cats[category] = 1;
				}
			});

			// add badge count to all badges
			for(category in cats) {
				this.$(".js_tabbed_content_navi")
					.find("[data-category=" + category+ "]")
					.removeClass(this.CSS.hasBadgeCount)
					.text( cats[category] > 0 ? cats[category] : "0" )
					.addClass( cats[category] > 0 ? this.CSS.hasBadgeCount : "" );
			}

		},

		// fetch tags and cats anew
		refreshTags: function()
		{	
			this.collections.catsAndTags.trigger(this.CUSTEVENTS.refreshTags);
		},

		// adds tags and categorie lists to all displatyed
		// blocks for availability when editing tags
		// are fetched by timer by main app view
		addTagsAndCats: function()
		{
			var tagsAndCats = this.collections.catsAndTags,
				// there will only be one model always
				// retrieve first one
				model = tagsAndCats.at(tagsAndCats.length-1).toJSON(),
				newCats = this.template_catList(model),
				newTags = this.template_tagList(model);

			this.$(".js_tag_selection").each(function(){
				$(this).html(newTags);
			});

			this.$(".js_pick_category").each(function(){
				$(this).html(newCats);
			});
		},

		activateTabbedContent: function(e)
		{
			this.$(".js_tabbed_navi").click(function(e) {
				e.preventDefault();
				$(this).tab("show");
			});
		},

		cleanView: function()
		{
			this.$(".js_results").toggleClass(this.CSS.clean);
		}
	});

	return View_Results;

});