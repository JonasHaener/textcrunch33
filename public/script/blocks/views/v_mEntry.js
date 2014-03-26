"use strict";

define(function(require) {
	
	var _ 		 	= require("underscore"),
		$		 	= require("jquery"),
		Backbone 	= require("backbone"),
		templ	 	= require("text!templates/tmpl_mEntry.html"),
		MESSAGES 	= require("messages/messages"),
		helper_tags = require("helpers/helper_tags"),
 	
	
	View_Entry = Backbone.View.extend({
		
		tagName: "div",

		// category will be provided by model 
		// when passed in
		// ## category is used temporarily here for testing
	 	category: "",

	 	template: _.template( templ ),

	 	// set by parent view
	 	parent: null,

		CSS:
		{
			entryIsCollapsed	: "egg-is-hidden-anim",
			entryIsOpen 		: "egg-is-visible-anim",
			openButton 			: "glyphicon-arrow-down",
			collapseButton 		: "glyphicon-arrow-up",
			unsavedContent		: "egg-face-unsaved-data",
			bookmark 			: "glyphicon-star",
			unbookmark			: "glyphicon-star-empty",
			includeInProject 	: "egg-face-included",
			formError 			: "egg-face-formError"
		},

		CUSTEVENTS:
		{
			// exclude from Project is sent to this view entry
			excludeFromProject	: "excludeFromProject",
			// include in project is sent to this view entry
			includeInProject	: "includeInProject",
			// unsaved is sent to this view entry
			unsavedData 		: "unsaved",
			// event is sent to project view
			removeFromProject   : "removeFromProject",
			// event is sent to project view
			addToProject		: "addToProject",
			// notify user of project completion
			updateComplete		: "updateComplete",
			updateError		    : "updateError"
		},

		events: {
			"click .js_bookmark_entry" 				: "bookmark",
			"click .js_remove_include_to_project" 	: "includeExcludeInProject",
			"click .js_open_close_entry" 			: "openCloseEntry",
			"click .js_edit_entry"					: "edit",
			"click .js_save_entry"					: "save",
			"click .js_hide_entry" 					: "hideEntry",
			"click .js_delete_entry" 				: "delete",

			"change   .js_pick_category" 			: function(e) {
				this.addCategory(e);
				this.updateTagsOverview(e);
				// do not provide event
				this.notifyUnsavedData();

			},

			"focusout .js_pick_tag" 				: function(e) {
				this.addTags(e);
				this.updateTagsOverview(e);
				// do not provide event
				this.notifyUnsavedData();
			},

			"keypress .js_pick_tag" 				: "addTags",
			"focus .js_lang"						: "notifyUnsavedData",
			// ".js_tag" is assigned dynamically in "getTag" function
			"dblclick .js_tag"						: function(e) { 
				this.removeTag(e);
				this.updateTagsOverview(e);
			},

			"focusout .js_lang"						: "cleanTextField"	
		},

		initialize: function() {
			// cleanup views, remove handlers -> assigned to prototype
			// this is used to cleanup when a previous models are destroyed
			// on collection reset
			this.listenTo(this.model, "cleanup", this.close);
			// listens to unsaved data event within this view
			this.listenTo(this, "unsaved", this.notifyUnsavedData);
			// important when text and tags are changed
			this.listenTo(this.model, "change:tags", this.updateTagsOverview);
			this.listenTo(this.model, "change:category", this.updateTagsOverview);
			// event is triggered on every model that is included
			// in user project
			this.listenTo(this.model, this.CUSTEVENTS.includeInProject, this.includeExcludeInProject);
			this.listenTo(this.model, this.CUSTEVENTS.excludeFromProject, this.includeExcludeInProject);

			//category is used for assignment in DOM
			this.category = this.model.get("category");
			// some model data needs to be worked
			this.arrangeModelData();
		},

		// cleanup Events view
		onClose: function()
		{
			console.log("cleanup runs in view onClose");
			//this.unbind("unsaved", this.notifyUnsavedData);
			// unbind all event handlers
			this.parent = null;
		},

		assignHooks: function()
		{
			this.$taggingSection 			= this.$(".js_tagging");
			this.$categoryEntry	 			= this.$(".js_category_entry");
			this.$tagsEntry		 			= this.$(".js_tags_entry");
			this.$blockContent	 			= this.$(".js_block_content");
			this.$languages	 	 			= this.$(".js_lang");
			this.$showHideEntryButt 		= this.$(".js_open_close_entry");
			this.$unsavedDataNotifier  		= this.$(".js_notify");
			this.$includeRemoveToProject 	= this.$(".js_remove_include_to_project");
			this.$tagsOverview 				= this.$(".js_tags_overview");
		},

		arrangeModelData: function()
		{
			//this.model.tags

		},

		// the "|" strips out if no space or content is provided 
		textCleanRegExpr: new RegExp("\[.+\]+(.+|)\[.+\]+", "igm"),

		// rendered after collection changed
		render: function() {
			var data = {
				model : this.model.toJSON(),
				domain : window.APP.domain
			};
			// assign user rights
			this.$el.html( this.template( data ));
			//this.model.toJSON())
			this.assignHooks();
			return this;	
		},

		bookmark: function(e)
		{
			var $target = $(e.currentTarget),
				classes = this.CSS;

				$target
					.toggleClass(classes.bookmark)
					.toggleClass(classes.unbookmark);
		},

		openCloseEntry: function(e)
		{
			 // function "edit" will send no event
			var $target = $(e.currentTarget),
				$block = this.$blockContent,
				classes = this.CSS;

				$block
					.toggleClass(classes.entryIsOpen)
					.toggleClass(classes.entryIsCollapsed);

				$target
					.toggleClass( classes.openButton )
					.toggleClass( classes.collapseButton );
		},

		edit: function(e)
		{
			var $target = $(e.currentTarget),
				classes = this.CSS;

				this.$taggingSection
					.toggleClass(classes.entryIsOpen)
					.toggleClass(classes.entryIsCollapsed);

				this.lockUnlockFormFields();	
				
				// open content only when form
				// is in collapsed state
				if(this.$blockContent.hasClass( this.CSS.entryIsCollapsed ))
				{
					this.$showHideEntryButt.click();
				}
		},

		lockUnlockFormFields: function()
		{
			var fields	= this.$languages,
				flag 	= fields.prop("disabled");

			if(flag === true)
			{
				fields.prop("disabled", "");
			
			} else if(flag === false)
			{
				fields.prop("disabled", "disabled");
			}

		},

		cleanTextField: function()
		{
			var _this = this;
			this.$languages.each(function(i, item) {
				var $item = $(item);
				//$item.val(  $item.val().replace(/\[.+\](.+)\[.+\]/, "$1").trim() );
				$item.val(  $item.val().replace(/\[.+\]+(.+|)\[.+\]+/ig, "$1").trim() );
				//[safety-1] ss [-end-]		
			});
		},


		getModelData: function()
		{
			var modelData 	= {},
				$langFields = this.$("[data-language]"),
				tagsTemp	= [],
				// form errors
				errorEle = [];

			// tags: #usb;#safety;#cleaning
			modelData.tags 		 = [];
			modelData.category 	 = this.$("[data-tagtype=category]").text().trim().substr(1);
			modelData.error 	 = false;
			modelData.lang_to_update = this.model.get("lang_to_update");	
			// extract languages
			$langFields.each(function(index, item)
			{
				var $item = $(item),
					_this = this,
					val = $item.find(".js_lang").val().trim();
				// only send attributes to server that
				// need to be updated or are not blank IMPORTANT!!!
				// otherwise entries are overwritten !!!
				if(val !== "") {
					modelData[ $item.attr("data-language") ] = 
						val.replace(/\[.+\]+(.+|)\[.+\]+/ig, "$1").trim();
				}	
			});

			// extract tags push into array
			this.$("[data-tagtype=tag]").each(function(index, item) {
				modelData.tags.push(item.textContent.trim().substr(1));
			});

			// validate
			if(modelData.tags.length <= 0)
			{
				modelData.error = true;
				errorEle.push("tags");
			}
			if(modelData.category.length <= 0)
			{
				modelData.error = true;
				errorEle.push("category");
			}
			if(modelData.german === "")
			{
				modelData.error = true;
				errorEle.push("german");
			}
			// inform user of form errors
			this.alertFormErrors(errorEle);
			return modelData;	
		},

		alertFormErrors: function(errorElements)
		{
			if(!Array.isArray(errorElements))
			{
				throw "Array expected";
			}
			
			var i, 
				n,
				formEles = {
					tags 		: this.$tagsEntry,
					category 	: this.$categoryEntry,
					german 		: this.$("[data-blocklang=german]")
				},
				errorClass = this.CSS.formError;
			// remove all error classes before adding error classes again	
			for(n in formEles) {
				formEles[n].removeClass(errorClass);
			}
			// add error classes to form elements	
			errorElements.forEach(function(ele, index){
				if(formEles[ele]) {
					formEles[ele].addClass(errorClass);
				}
			});
		},

		// updates dynamically when tag and category changes are saved
		updateTagsOverview: function() {
			var cat = this.$categoryEntry.find("[data-tagtype=category]").text(),
				tags = "";
			
			this.$tagsEntry.find("[data-tagtype=tag]").each(function(index, item, list) {
				tags += " / " + $(item).text();
			});
			this.$tagsOverview.text(cat + tags); 
		},

		setIncludedInProjectStatus: function(include)
		{
			var $button = this.$includeRemoveToProject;
			// exlude, remove from project
			if(include === false)
			{
				$button.removeClass(this.CSS.includeInProject);
				// notify project view to remove from block ids					
				this.model.set("inProject", false);
				return;
			}
			if(include === true)
			{
				$button.addClass(this.CSS.includeInProject);
				this.model.set("inProject", true);
				return;
			}
		},

		includeExcludeInProject: function (e) 
		{
			// below if is used when running first
			// scan after retrieving models from DB
			var model = this.model;

			if(e.type === this.CUSTEVENTS.includeInProject)
			{
				this.setIncludedInProjectStatus(true);				
				return;
			}
			if(e.type === this.CUSTEVENTS.excludeFromProject)
			{
				this.setIncludedInProjectStatus(false);				
				return;
			}
			if(e.type === "click")
			{
				if(model.get("inProject") === true)
				{
					this.setIncludedInProjectStatus(false);	
					model.trigger(this.CUSTEVENTS.removeFromProject, { model: model });
					return;
				}

				if(this.model.get("inProject") === false)
				{
					this.setIncludedInProjectStatus(true);	
					model.trigger(this.CUSTEVENTS.addToProject, { model: model });
					return;
				}
			}
		},

		validateInp: function(inp) {

		},

		notifyUnsavedData: function(flag)
		{
			if(flag === false) {
				this.$unsavedDataNotifier.removeClass( this.CSS.unsavedContent );
			
			} else {
				this.$unsavedDataNotifier.addClass( this.CSS.unsavedContent );

			}
			
		},

		addCategory: function(e)
		{
			var flag = false,
				target = e.currentTarget,
				flag =  (e.type === "change") ? true : 
				   		(e.type === "focusout" || e.type === "blur") ? true : false,
				val = target.value.trim(),
				firstItem = "",
				rexComma = /(,+)/;

			if(flag && val !== "")
			{	
				// ensure that no more than one item is added as category
				// split into array and replace commas if present
				// create a tag with first item
				firstItem = val.split(" ")[0].replace(rexComma, "");
				// append category entry
				this.$categoryEntry.html( helper_tags.createTag( "@" + firstItem, "category") );
				//notify unsaved data
				this.trigger( this.CUSTEVENTS.unsavedData );
			}
		},

		addTags: function(e)
		{
			var flag = false,
				target = e.currentTarget,
				val = target.value;

			flag = (e.type === "keypress" && e.which === 13) ? true : 
				   (e.type === "focusout" || e.type === "blur") ? true : false;

			if(flag && val !== "")
			{
				this.sortAndAddTags( val ); 
				//notify unsaved data
				this.trigger( this.CUSTEVENTS.unsavedData );
				target.value = "";
			}
		},

		sortAndAddTags: function(tags)
		{
			var _this = this,
				tagInp = tags.split(" "),
				rexComma = /(,+)/,
				newTags = [],
				existingTags = [];
			
			this.$tagsEntry.find(".js_tag").each(function(index, item) {
				existingTags.push(item.textContent.substr(1));
			});

			// extract all tags
			tagInp.forEach(function(tag, index) {
				newTags.push(tag.replace(rexComma, "").trim().toLowerCase());
			});
			
			newTags.forEach(function(tag, index)
			{
				// eliminate duplicates and add to view
				if(!helper_tags.isDuplicatedTag( existingTags, tag)) {
					_this.$tagsEntry.append( helper_tags.createTag( "#" + tag, "tag") ); 
					
				}
			});
		},

		removeTag: function(eventData)
		{
			if(eventData.type === "dblclick")
			{
				$(eventData.currentTarget).remove();
				return;
			}
		},

		notifyConfirm: function(type)
		{
			return confirm( MESSAGES[type] );
		},

		hideEntry: function()
		{
			// removes from DOM but
			// does not destroy the
			// model
			var mod = this.model;
			if( this.notifyConfirm("hide") )
			{
				// model DELETE request is not sent to DB
				mod.trigger(this.CUSTEVENTS.removeFromProject, { model: mod });	
				mod.trigger("destroy", mod);
				// kill view remove handlers
				// function on prototype			
				this.close();
			}
		},

		save: function()
		{
			var _this = this,
				modelData = this.getModelData();

			if(modelData.error) {
				return;			
			
			} else {
				// add progress bar
				this.parent.router.inprogress(true);
				// save entry
				this.model
					.save(modelData, { validate: true, wait: true })
					.then(
						// success
						function() {						
							// notify user of saved 
							_this.parent.router.actionSuccess();
							// remove progress bar
							_this.parent.router.inprogress(false);
							_this.notifyUnsavedData(false);

						},
						// fail
						function() {
							_this.parent.router.actionError();
							// remove progress bar
							_this.parent.router.inprogress(false);							
						}
					);
			}
		},

		delete: function() {
			// warn of unsaved data
			var _this = this,
				mod = this.model;

			if( this.notifyConfirm("delete") )
			{
				// add progress bar
				this.parent.router.inprogress(true);
				// destro model
				this.model.destroy({
					success: function(model, response) {
						_this.parent.collections.blockEntries.trigger(_this.CUSTEVENTS.removeFromProject, { model: mod });
						// remove view from DOM
						_this.parent.router.actionSuccess();
						// remove progress bar
						_this.parent.router.inprogress(false);
						// destroy view
						_this.close();
					},
					error: function(xhr, status, error) {
						_this.parent.router.actionError();
						// remove progress bar
						_this.parent.router.inprogress(false);						
					}	
				}, 
				{ 
					wait: true
				});
			}
		}
	});

	return View_Entry;

});	