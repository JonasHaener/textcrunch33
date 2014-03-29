"use strict";


define(function(require){

	var _ 				= require("underscore"),
	$ 					= require("jquery"),
	Backbone 			= require("backbone"),
	templView 			= require("text!templates/tmpl_mSearchSettings.html"),
	templTags			= require("text!templates/tmpl_tag.html"),
	templCatsAndTags 	= require("text!templates/tmpl_option_cats_and_tags.html"),
	helper_tags 		= require("helpers/helper_tags"),
	helper_util 		= require("helpers/helper_util"),
	MESSAGES 			= require("messages/messages"), 

	View_SearchSettings = Backbone.View.extend({

		tagName: "div",
		className: "",


		templates: 
		{
			$templateView: _.template( templView ),
			$templateCatsAndTags: _.template( templCatsAndTags ) 
		},


		collections:
		{
			// blockEntries (set by parent)
			// catsAndTags (set by parent)
			// prefetchEntries (set by parent)
		},


		router:
		{
			// set by parent
		},


		setForeignCollection: function(collection)
		{
			var i;
			for(i in collection)
			{
				this.collections[i] = collection[i];
			}
		},


		events:
		{
			"focusin    .js_search_tag" 		: "refreshTags",
			"focusout	.js_search_tag" 		: "addTags",
			"keypress	.js_search_tag" 		: "addTags",
			"click 		.js_submit_search" 		: "submitSearch",
			"dblclick 	.js_tag" 	 			: "removeTagFromSearch",
//			"click		.js_search_all_lang" 	: "switchLangConfig",
			"click		[type=checkbox]"		: "updateCheckBoxStatus"
		},
		
		
		CUSTEVENTS:
		{
			blocksLoaded	  : "blocksLoaded",
			tagsAndCatsLoaded : "tagsAndCatsLoaded",
			updateComplete	  : "updateComplete",
			updateError		  : "updateError",
			refreshTags 	  : "refreshTags",
			dataPrefetched	  : "dataPrefetched",
			fetchBlocks 	  : "fetchBlocks",
			prefetch 		  : "prefetch"

		},		


		initialize: function()
		{	

		},
		
		
		// cleanup Events view
		onClose: function()
		{
			console.log("cleanup runs in view onClose");
			this.router = this.collections = null;
		},


		addListeners: function()
		{
			// prefetch blocks
			this.listenTo(this.collections.blockEntries, this.CUSTEVENTS.prefetch, this.prefetchBlocks);
			// prefetched blocks
			this.listenTo(this.collections.blockEntries, this.CUSTEVENTS.dataPrefetched, this.fetchBlocks);
			// fetch prefetched ids
			this.listenTo(this.collections.blockEntries, this.CUSTEVENTS.fetchBlocks, this.fetchBlocks);
			// when tags are loaded add
			this.listenTo(this.collections.catsAndTags, this.CUSTEVENTS.tagsAndCatsLoaded, this.addTagsAndCats);
		},


		assignHooks: function()
		{
			this.$searchItems 			= this.$(".js_search_items");
			this.formData.checkbox.all 	= this.$("[type=checkbox]");
			this.$tagCatSelection 		= this.$(".js_tag_cat_selection");
		},
			
			
		render: function()
		{
			this.$el.html( this.templates.$templateView() );
			this.assignHooks();
			this.addListeners();
			this.updateCheckBoxStatus();
			return this;
		},


		prefetchedIds: [],

		// holds formData to be submitted
		// used when submitting search
		// and for comparison of double entries
		formData:
		{
			settings:
			{
				prefetch: false,
				category: [],
				tag: [],
				id: [],
				searchGerman: true,
				searchEnglish: false,
				searchAllLang: false,
				// reset checkbox status
				searchReplaceResults: false,
				// used for foreign calls to reset when needed
			},
			
			checkbox:
			{
				//added by assignHooks
			},
			
			addTag: function(tagToAdd, type)
			{
				if(this.settings[type])
				{
					this.settings[type].push(tagToAdd);
				
				} else
				{
					throw "Missing: Attribute does not exist on formData object";
				}

			},

			removeTag: function(tagToRemove, type)
			{
				if(!this.settings[type])
				{
					throw "Attribute does not exist on formData object";
				}					

				var i,
				len,
				tags = this.settings[type],
				val = tagToRemove.trim();

				for(i = 0, len = tags.length; i < len; i+=1)
				{
					if( tags[i] === val)
					{
						tags.splice(i, 1);
						break;
					}
				}
				console.log(this.settings.id);
				console.log(this.settings.tag);
				console.log(this.settings.category);
			},

			reset: function(tags)
			{
				if(arguments.length <= 0)
				{
					// reset all tags
					this.settings.category = []; 
					this.settings.tag = [];
					this.settings.id = [];
				
				} else {
					if (!this.settings[tags])
					{
						throw "Attribute undefined on formData object";
						return;
					}
					this.settings[tags] = [];
				}
					
			}
		},
		
		
		clearSearchForm: function()
		{
			this.$searchItems.empty();
		},
		
		
		resetPrefetchIds: function()
		{
			console.log("reset");
			
			this.prefetchedIds = [];
			// reset total count
			this.router.updateTotal("0");
		},
		
		// switches checkboxes
		// if all languages is selected then
		// german and english are unchecked
		updateCheckBoxStatus: function(e)
		{
			var formData = this.formData;
			this.formData.checkbox.all.each(function(index, item)
			{	
				var $item = $(item),
				dataType = $item.attr('data-search');

				if(formData.settings[dataType] === undefined)
				{
					throw "Undefined attribute on formData.settings";
					return;
				}
				// update checkbox status for later
				// submission to database
				formData.settings[ dataType ] = $item.prop("checked");
			});
		},
		

		addTags: function(e)
		{
			var flag = false,
			target 	= e.currentTarget;

			flag = (e.type === "keypress" && e.which === 13) ? true : 
				   (e.type === "focusout" || e.type === "blur") ? true : false;

			if(flag)
			{
				this.sortTags(target.value);
				target.value = "";
			}
		},
		

		sortTags: function(tags)
		{
			var _this = this,
				tagInp = tags.split(" "),
				rexComma = /[,\s]/,
				formData = this.formData,
				hashTag = "";
			
			tagInp.forEach(function(tag, index)
			{
				tag = tag.replace(rexComma, "").trim().toLowerCase();
				var hashTag = tag.charAt(0),
				// id has no tag
				// for cat and tag hashtag needs to be removed
				// before submitting to formData
				tagOrCatItem = tag.substr(1);
				// if value can be converted into integer 
				if( !isNaN(tag) && tag !== "" )
				{
					tag = parseInt(tag, 10).toString();
					// check for duplicates
					if( !helper_tags.isDuplicatedTag(formData.settings.id, tag) )
					{
						// push to formData object for
						// submission
						formData.addTag(tag, "id");
						_this.addTagToSearch(tag, "id");
					}
				}
				// if value cannot be converted into integer
				// all items that contain a hastag and are characters
				else if(tag !== "")
				{
					switch(hashTag)
					{
						case "@":
							if( !helper_tags.isDuplicatedTag(formData.settings.category, tagOrCatItem) )
							{
								// push to formData object for
								// submission
								formData.addTag(tagOrCatItem, "category");
								_this.addTagToSearch(tag, "category");
							}
						break;
						case "#":
							if( !helper_tags.isDuplicatedTag(formData.settings.tag, tagOrCatItem) )
							{
								// push to formData object for
								// submission
								formData.addTag(tagOrCatItem, "tag");
								_this.addTagToSearch(tag, "tag");
							}
						break;
						case "!":
							_this.removeTagFromSearch({ "kill": tag });
						break;
					}
				}
			});
		},
		

		addTagToSearch: function(val, tagKind)
		{
			var $searchItems = this.$searchItems;
			if(val === "kill")
			{
				$searchItems.empty();
				return;
			}
			$searchItems.append( helper_tags.createTag(val, tagKind) );
		},


		removeTagFromSearch: function(eventData)
		{
			var $target  = $(eventData.currentTarget),
			data_tagtype = $target.attr("data-tagtype"),
			tagValue 	 = $target.text();

			// when tag is double clicked
			if(eventData.type === "dblclick")
			{
				if( !isNaN(tagValue))
				{
					this.formData.removeTag( tagValue, data_tagtype );
				
				} else {
					this.formData.removeTag( tagValue.substr(1), data_tagtype );
				} 
				$target.remove();
				return;
			}

			// no true event object available here
			if(eventData.kill)
			{
				var killStr = eventData.kill.trim(),
				killKind 	= killStr.substr( killStr.indexOf("!")+1 );

				switch(killKind)
				{
					case "#":
						this.formData.reset("tag");
						this.$searchItems.children("[data-tagtype=tag]").remove();
					break;
					case "@":
						this.formData.reset("category");
					 	this.$searchItems.children("[data-tagtype=category]").remove();
					break;
					case "id":
						this.formData.reset("id");
						this.$searchItems.children("[data-tagtype=id]").remove();
					break;
					case "kill":
						this.formData.reset();
						this.$searchItems.empty();
					break;
				}
			}
		},


		prepFormData: function(formData)
		{
			
			var i,
				convData = {};
			// copy attributes
			// cannot directly convert array to string -> reference
			// convert arrays to string for GET request submission
			for(i in formData) {
				convData[i] = formData[i];
				if( Array.isArray(convData[i]) ) {
					convData[i] = convData[i].join(";");
				}
			}
			return convData;
		},


		sortPrefetchedData: function( reset )
		{
			var coll = this.collections.prefetchEntries,
				// reset prefetched ids
				prefIds = (reset === true) ? this.prefetchedIds = [] : this.prefetchedIds;
				
			coll.each(function(model, index, list) {
				prefIds.push(model.get("block_id"));
			});
			// empty collection
			coll.reset();

			// remove doubles
			this.prefetchedIds = _.uniq(prefIds);
		},


		getIdsToFetch: function(ids)
		{
			var i,
				rationed = [],
				size = (ids.length > 10) ? 10 : ids.length;

			for(i = 0; i < size; i+=1) {
				rationed.push( ids.shift() );
			}
			
			return rationed;	
		},
		
		
		getBlocks: function(collection, configs)
		{	
			this.router.inprogress(true);
			collection.fetch(configs);
		},


		prefetchBlocks: function(settings)
		{
			
			var i,
				_this		= this,
				sett 		= settings || {},
				configs 	= null,
				fetchData 	= this.prepFormData(this.formData.settings);


			// apply custome settings
			for(i in fetchData) {
				fetchData[i] = (sett[i] === undefined) ? fetchData[i] : sett[i];
			}
			
			fetchData.prefetch = true;
			fetchData.searchReplaceResults = sett.searchReplaceResults || fetchData.searchReplaceResults;
			
			configs = {
				
				data 	: fetchData,
				
				remove	: false,
				
				reset	: fetchData.searchReplaceResults,
				
				success: function(collection, response, options)
				{
					
					if(response.length > 0) {
						_this.sortPrefetchedData( fetchData.searchReplaceResults );
						// fetch the first items automatically
						// call to fetch
						_this.collections.blockEntries.trigger(_this.CUSTEVENTS.dataPrefetched, { replace: fetchData.searchReplaceResults });
						
					// if no search results
					}  else {
						_this.router.actionError();
					}

					_this.router.inprogress(false);
				},
				
				error: function(collection, response, options)
				{
					// alert error
					_this.router.actionError();
					_this.router.inprogress(false);
				} 
			};
			
			// fetch blocks
			this.getBlocks(this.collections.prefetchEntries, configs);
			
		},


		fetchBlocks: function(settings)
		{
			var i,
				ids 	 = this.getIdsToFetch(this.prefetchedIds),
				_this 	 = this,
				configs  = null,
				settings = settings || {},
				formData = this.prepFormData(this.formData.settings),
				// replace can be set within prefetch
				replace  = settings.replace || this.formData.settings.searchReplaceResults;

			// format ";" used after prefetch
			// get next batch of ids to fetch
			formData.id = ids.join(";");
			
			// avoid another http request when 
			// no data to fetch
			if(formData.id === "") {
				_this.router.actionError();
				return;
			}
		
			configs = {
				
				data: formData,

				remove: false,

				reset: replace,
				
				success: function(collection, response, options)
				{
					if(response.length > 0) {
						
						// if no records are found GET HTTP response is 204 -> no error
						// alert user however of no records found
						// collection lenght is lenght of entire collection not just added new ones
						// compare length
						_this.collections.blockEntries.trigger(_this.CUSTEVENTS.blocksLoaded);
						_this.router.actionSuccess();

					} else {
						// if fetch fails restore ids
						//_this.restoreDataIds( blockIdsToFetch );
						_this.router.actionError();
					}

					// remove progress bar
					_this.router.inprogress(false);					
					
					// indicates if more data can be fetched
					_this.notifyMoreDataToFetch();	

					// update prefetched data
					_this.router.updateTotal( _this.prefetchedIds.length );
				},
				
				error: function(collection, response, options)
				{
					// if fetch fails restore ids
					_this.restoreDataIds( ids );
					// update prefetched data
					_this.router.updateTotal( _this.prefetchedIds.length );
					// alert error
					_this.router.actionError();
					// remove progress bar
					_this.router.inprogress(false);
				}
			};
			
			// fetch blocks
			this.getBlocks(this.collections.blockEntries, configs);
			
		},
		
		
		restoreDataIds: function(restIds)
		{
			var i,
				len,
				ids = this.prefetchedIds;

			for(i = restIds.length-1; i >= 0; i-=1) {
				ids.unshift(restIds[i]);
			}
		},


		notifyMoreDataToFetch: function(flag) 
		{
			// force turn off notification
			if(flag === false) {
				this.router.notifyMoreData(false);

			} else if(this.prefetchedIds.length < 1) {
				this.router.notifyMoreData(false);
			
			} else {
				this.router.notifyMoreData(true);
			
			}

		},


		submitSearch: function(e)
		{
			var attrs = this.formData.settings;
			if(attrs.category.length > 0 || attrs.tag.length > 0 || attrs.id.length > 0)
			{
				// reset prefetch ids
				this.resetPrefetchIds();
				// turn off more data to fetch				
				this.notifyMoreDataToFetch(false);
				// prefetch blocks
				this.prefetchBlocks();

			// allows user to remove views and reset collection
			// without calling any search data
			} else if(this.formData.settings.searchReplaceResults === true) {
				// reset blockentries
				this.collections.blockEntries.reset();
				// reset prefetch ids
				this.resetPrefetchIds();
				// turn off more data to fetch				
				this.notifyMoreDataToFetch(false);
				// reset form data
				this.formData.reset();
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
				data = tagsAndCats.at(tagsAndCats.length-1).toJSON();

			this.$tagCatSelection.html( this.templates.$templateCatsAndTags(data) );
		},

		// fetch tags and cats anew
		refreshTags: function()
		{	
			this.collections.catsAndTags.trigger(this.CUSTEVENTS.refreshTags);
		}
		
	});

	return View_SearchSettings;

});