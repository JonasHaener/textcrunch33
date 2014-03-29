"use strict";


define(function(require){

	var _ 				= require("underscore"),
		$ 				= require("jquery"),
		Backbone 		= require("backbone"),
		templ 			= require("text!templates/tmpl_mEntryForm.html"),
		templ_tagList	= require("text!templates/tmpl_option_tag.html"),
		templ_catList	= require("text!templates/tmpl_option_cat.html"),
		Model 			= require("models/m_mEntry"),
		Collection_entry= require("collections/c_mEntry"),
		helper_tags  	= require("helpers/helper_tags"),
		MESSAGES 		= require("messages/messages"),

	View_EntryForm = Backbone.View.extend({

		tagName: "div",

		className: "",

		template 			: _.template( templ ),
		template_tagList	: _.template( templ_tagList ),
		template_catList	: _.template( templ_catList ),

		CUSTEVENTS:
		{
			refreshTags 	  : "refreshTags"
		},

		events: {
			"click      .js_show_form" 		: "showForm",
			"click      .js_hide_form" 		: "hideForm",
			"click      .js_save_entry"		: "createEntry",
			"click      .js_clear_form"		: "clearForm",

			"focusin 	.js_pick_tag" 		: "refreshTags",
			"focusout 	.js_pick_tag" 		: "addTags",
			"keypress 	.js_pick_tag" 		: "addTags",
			
			"change 	.js_pick_category"	: function(e) {
				this.addCategory(e);
				this.refreshTags(e);
			},
			// "js_tag" dynamically assigned in "getTag" function
			"keypress	textarea"			: "registerUnsavedData",
			"dblclick   .js_tag"			: "removeTag"
		},

		collections: 
		{
			// set by parent
			catsAndTags: null,
			// set by parent
			newEntries : null
		},

		// assigned by parent
		router: null,


		initialize: function() {
			
		},

		// cleanup Events view
		onClose: function()
		{
			console.log("cleanup runs in view onClose");
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

		assignListeners: function() {
			this.listenTo(this.collections.newEntries, "add", this.unRegisterUnsavedData);
			this.listenTo(this.collections.catsAndTags, "tagsAndCatsLoaded", this.addTagsAndCats);
		},

		assignHooks: function()
		{
			this.$categoryEntry  = this.$(".js_category_entry");
			this.$tagsEntry		 = this.$(".js_tags_entry");
			this.$formContent	 = this.$(".js_form_content");
			this.$tagSelection 	 = this.$(".js_tag_selection");
			this.$catSelection 	 = this.$(".js_pick_category");
		},
			
		render: function()
		{
			var data = {
				domain : window.APP.domain
			};
			this.$el.html( this.template(data) );
			this.assignListeners();
			this.assignHooks();
			//this.hideForm();
			return this;
		},

		CSS:
		{
			tags 		: "egg-face-",
			hideForm 	: "egg-is-hidden-anim",
			showForm 	: "egg-is-visible-anim",
			formError 	: "egg-face-formError"
		},

		tagTypes:
		{
			dataType: 	"data-tagtype",
			category: 	"category",
			tag: 		"tag"
		},

		// formData holds data when tags are added and removed 
		// when creating an entry
		// for easy retrieval upon saving of model
		formData:
		{
			category: "",
			
			tags: [],

			addCateg: function(newCateg)
			{
				this.category = newCateg.trim();

			},

			addTag: function(newTag)
			{
				this.tags.push( newTag.trim() );
			},

			removeCateg: function()
			{
				this.category = "";
			},

			removeTag: function(val)
			{
				var i,
					len,
					tags = this.tags,
					val = val.trim();

				for(i = 0, len = tags.length; i < len; i+=1)
				{
					if(tags[i] === val)
					{
						tags.splice(i, 1);
						break;
					}
				}
			},

			resetTags : function()
			{
				this.tags = [];
			}
		},

		// flag to set unsaved data
		registerUnsavedData: function() {
			this.unsavedData = true;
		},

		unRegisterUnsavedData: function(model)
		{
			this.unsavedData = false;
		},
		
		showForm: function() 
		{
			this.$formContent
				.removeClass(this.CSS.hideForm)
				.addClass(this.CSS.showForm);
		},

		hideForm: function()
		{
			this.$formContent
				.removeClass(this.CSS.showForm)
				.addClass(this.CSS.hideForm);
		},

		getModelData: function()
		{
			var modelData = {},
				$langFields = this.$formContent.find("[data-blocklang]");

			modelData.tags 		 = this.formData.tags;
			modelData.category 	 = this.formData.category;
			modelData.catInitial = modelData.category.charAt(0).toUpperCase();
			modelData.error 	 = false;			

			$langFields.each(function(index, item)
			{
				var $item = $(item),
					dataTag = $item.attr("data-blocklang");
				modelData[dataTag] = $item.val();
			});

			// ##VALIDATION
			var errorEle = [];
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

		createEntry: function()
		{
			var _this = this,
				modelData = this.getModelData();
			// if errors, cancel creation
			// data will be validated again in model
			// in case it fails here
			if(modelData.error === true) {
				return; 
			}

			// add progress bar
			this.router.inprogress(true);			

			// wait for server confirmation
			this.collections.newEntries
			.create(modelData, 
			{ 
				validate: true, 
				
				wait: true,
				
				success: function() {
					_this.router.actionSuccess();
					// remove progress bar
					_this.router.inprogress(false);					
				},
				
				error: function() {
					_this.router.actionError();
					// remove progress bar
					_this.router.inprogress(false);					
				} 
			});
			//this.clearForm();
		},

		clearForm: function()
		{
			var clearData = (this.unsavedData === true) ? this.warnUnsavedData() : true; 
			if(clearData === true)
			{
				this.$("textarea, input").val("");
				this.$tagsEntry.empty();
				this.$categoryEntry.empty();
				// reset tags
				this.formData.resetTags();
				// reset all form error alerts
				this.alertFormErrors([]);
			}
		},

		warnUnsavedData: function()
		{
			return confirm( MESSAGES.unsaved );
		},

		addCategory: function(e)
		{
			var flag = false,
				target = e.currentTarget,
				flag =  (e.type === "change") ? true : 
				   		(e.type === "focusout" || e.type === "blur") ? true : false,
				val = target.value.trim().toLowerCase();

			if(flag && val !== "")
			{	
				// add categroy to form data collection
				this.formData.addCateg(val);
				// append category entry
				this.$categoryEntry.html( helper_tags.createTag("@" + val, this.tagTypes.category) );
				this.registerUnsavedData();
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
				this.registerUnsavedData();
				target.value = "";
			}
		},

		sortAndAddTags: function(tags)
		{
			var i,
				len,
				tagInp = tags.split(" "),
				rexComma = /(,+)/,
				currTag,
				docFrag = $(window.document.createDocumentFragment());

			for(i = 0, len = tagInp.length; i < len; i+=1)
			{	
				currTag = tagInp[i] = tagInp[i].replace(rexComma, "").trim().toLowerCase();
				// look for duplicated tags
				if( helper_tags.isDuplicatedTag( this.formData.tags, currTag) === true )
				{
					continue;
				}
				// add tag to form data collection
				this.formData.addTag( currTag );
				// create a tag with item value
				// specify tag type
				docFrag.append( helper_tags.createTag( "#" + currTag, this.tagTypes.tag) ); 
			}
			this.$tagsEntry.append( docFrag ); 

		},

		removeTag: function(evt)
		{
			if(evt.type !== "dblclick")
			{
				return;
			}
			var tagTypes = this.tagTypes,
				$target = $(evt.currentTarget);

			// if a tag then remove from collection
			if( $target.attr(tagTypes.dataType) === tagTypes.tag)
			{
				// substr removes #hash tag
				this.formData.removeTag( $target.text().substr(1) );
				$target.remove();
			}
			// if a category then remove from collection
			if( $target.attr(tagTypes.dataType) === tagTypes.category)
			{
				this.formData.removeCateg();
				$target.remove();
			}
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
				newTags = this.template_tagList(model),
				$catSelector = this.$(".js_pick_category").find(".js_placeholder");

			this.$tagSelection.html(newTags);
			this.$catSelection
				.empty()
				.append($catSelector)
				.append(newCats)
		},

		// fetch tags and cats anew
		refreshTags: function()
		{	
			this.collections.catsAndTags.trigger(this.CUSTEVENTS.refreshTags);
		}
	
	});

	return View_EntryForm;

});