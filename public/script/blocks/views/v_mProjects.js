"use strict";


define(function(require){

	var _ 					= require("underscore"),
		$ 					= require("jquery"),
		Backbone 			= require("backbone"),
		helpers				= require("helpers/helper_util"),
		templNavi			= require("text!templates/tmpl_mProjects_navi.html"),
		templProjects   	= require("text!templates/tmpl_mProjects_projects.html"),
		templNewCreatEntries= require("text!templates/tmpl_mProjects_newCreatedUserEntries.html"),
		Model_Project 		= require("models/m_mProjects"), 
		Collection_Projects = require("collections/c_mProjects"),
		MESSAGES			= require("messages/messages"),


	View_Projects = Backbone.View.extend({
		tagName: "div",
		className: "",

		templateNavi: _.template( templNavi ),
		templateProjects: _.template( templProjects ),
		templateNewCreatedEntries: _.template( templNewCreatEntries ),

		events: {
			"click .js_create_new_project"		: "setNewProjectCreation",
			"click .js_fetch_project_blocks"	: "fetchProjectBlocks", 
			"click .js_extend_project_blocks"	: "extendProjectBlocks",
			"click .js_save_project"			: "saveProject",
			"click .js_delete_project"			: "deleteProject",

			"dblclick .js_block_ids"			: "unlockAndLockBlockIds",
			"focus .js_block_ids" 				: "unlockAndLockBlockIds",
			"focusout .js_block_ids"			: function(e) {
				this.unlockAndLockBlockIds(e);
				this.setIncludedBlocks(e);
			},
			// set included blocks when ids are edited
			// switches block ids when choosing different identifier
			"change .js_project_selection" 		: function(e) {
				this.switchDisplayedCollection();
				this.setIncludedBlocks();
			},
			"click .js_new_user_entry" 			: "getNewCreatedEntry"
		},

		router: {
			// set by parent
		},

		collections: 
		{
			// set during initialization
			projects: null,
			// blockEntries is set by app main view
			blockEntries: null,
			// new entries created by user
			newEntries: null
		},

		CUSTEVENTS:
		{
			excludeFromProject	: "excludeFromProject",
			includeInProject	: "includeInProject",
			isInProject	 		: "isInProject",
			blocksLoaded		: "blocksLoaded",
			// event is sent from block model
			removeFromProject   : "removeFromProject",
			// event is sent from block model
			addToProject		: "addToProject",
			ajaxFailed 			: "failedServerCall",
			updateComplete		: "updateComplete",
			updateError		    : "updateError",
			fetchBlocks 	  	: "fetchBlocks",
			prefetch 		    : "prefetch"
		},

		CSS: 
		{	
			inProgress 		: "egg-face-inprogess",
			formError 		: "egg-face-formError"
		},

		initialize: function() {
			this.collections.projects = new Collection_Projects();
		},

		// cleanup Events view
		onClose: function()
		{
			console.log("cleanup runs in view onClose");
			this.router = this.collections = null;
		},

		addListeners: function()
		{
			this.listenTo(this.collections.projects, "add", function(e) {
				// add projects to selection;
				this.addProject(e);
				// update first displayed project
				this.switchDisplayedCollection(e);
			});
			this.listenTo(this.collections.projects, "destroy", this.updateProjects);
			// display collection of new displayed project after removoval
			this.listenTo(this.collections.projects, "destroy", this.switchDisplayedCollection);
			// when blocks are loaded set included block ids
			// fired by this (self) view
			this.listenTo(this.collections.blockEntries, this.CUSTEVENTS.blocksLoaded, this.setIncludedBlocks);
			// add blocks to project
			this.listenTo(this.collections.blockEntries, this.CUSTEVENTS.addToProject, this.addToProject);
			// remove block from project
			this.listenTo(this.collections.blockEntries, this.CUSTEVENTS.removeFromProject, this.removeFromProject);
			// add last new Entries to last entries overview --> volatile, which remove when browser is closed
			this.listenTo(this.collections.newEntries, "add", this.addNewEntries);

		},

		setForeignCollection: function(collection)
		{
			var i,
			coll = this.collections;
			for(i in collection)
			{
				if( coll[i] === undefined )
				{
					throw "Undefined collection attribute on this.collections";
					return;
				}
				coll[i] = collection[i];
			}
		},

		assignHooks: function()
		{
			this.$newProjectId				= this.$(".js_new_project_id");
			this.$projectSelection 			= this.$(".js_project_selection");
			this.$blockIdField	 			= this.$(".js_block_ids");
			this.$buttNewProject 			= this.$(".js_create_new_project");
			this.$buttFetchProjectBlocks 	= this.$(".js_fetch_project_blocks");
			this.$buttSaveProject 			= this.$(".js_save_project");
			this.$buttDeleteProject			= this.$(".js_delete_project");
			this.$buttExtendProject			= this.$(".js_extend_project_blocks");
			this.$newUserCreatedEntries 	= this.$(".js_new_user_created_entries");
		},
			
		render: function() {
			this.$el.html( this.templateNavi() );
			this.assignHooks();
			this.addListeners();
			this.collections.projects.fetch();
			//this.setIncludedBlocks();
			return this;
		},

		formData: 
		{
			blocks : []
		},

		// controls navigation when a new project
		// is under creation
		newProjectInProgress: false,
		
		// creates a new project
		setNewProjectCreation: function()
		{
			var $field = this.$newProjectId,
				inProgress = this.newProjectInProgress;
			// remove all form errors
			$field.removeClass(this.CSS.formError);
			// if in project creation in progress
			if(inProgress === true) {
				this.newProjectInProgress = false;
				$field
					.removeClass(this.CSS.inProgress)
					.prop("disabled", true)
					.val("");
			
			} else if (inProgress === false) {
				if( !confirm(MESSAGES.confirm_no_unsaved) === true ) { return; }
				this.newProjectInProgress =  true;
				this.$blockIdField.val("");
				$field
					.addClass(this.CSS.inProgress)
					.prop("disabled", false);
				// if views are marked as included then remove marker now
				this.setIncludedBlocks();
			}
		},

		// adds project to project selection field
		addProject: function(project)
		{
			this.$projectSelection.prepend( this.templateProjects( project.toJSON() ) );
		},

		// refreshes project list
		updateProjects: function()
		{
			var _this = this;
			// clear project selection
			// keep placeholder in place
			this.$projectSelection.children().not(".js_placeholder").remove();
			// add all projects anew
			this.collections.projects.each(function(model, index)
			{	
				_this.addProject(model);
			});
		},
		
		unlockAndLockBlockIds: function(e)
		{
			var $idField = this.$blockIdField;
			if(e.type === "focusin")
			{
				window.clearTimeout(this.unlockTimer);
			}

			if(e.type === "dblclick")
			{
				window.clearTimeout(this.unlockTimer);
				$idField.prop("disabled", "");
			}
	
			if(e.type === "focusout")
			{
				//$idField.prop("disabled", "disabled");
				this.unlockTimer = setTimeout(function(){
					if($idField.prop("disabled") === false)
					{
						$idField.prop("disabled", "disabled");
					}
				}, 2000);
			}
		},

		// setIncludedBlocks sets the 
		// the models included flag to true
		// if block id is included 
		setIncludedBlocks: function(customBlocks)
		{
			var _this 	   = this,
				projectIds = (Array.isArray(customBlocks)) ? customBlocks : this.getBlockIds(true),
				blockColl  = this.collections.blockEntries;
			// if project id exists on project
			// trigger view event to set block to included
			blockColl.each(function(model, index)
			{	
				if( _.contains(projectIds, model.get("block_id")) )
				{
					// will trigger event on entry view 
					// to set included button to included
					model.trigger(_this.CUSTEVENTS.includeInProject, { type: _this.CUSTEVENTS.includeInProject });
				}
				else
				{
					model.trigger(_this.CUSTEVENTS.excludeFromProject, { type: _this.CUSTEVENTS.excludeFromProject });
				}
			});
			// update block ids field
			this.displayUpdatedCollection(projectIds);
		},

		// trims id form fields
		getBlockIds: function(needArray)
		{
			if(arguments.length > 0 && needArray !== true) 
			{
				throw "getBlockIds : wrong arguments provided";
			}

			var vals = this.$blockIdField.val(),
				empty = (vals === "") ? true : false,
				ids = [];
			
			if(empty)
			{
				return (needArray === true) ? [] : (arguments.length <= 0) ? "" : "";
			}
			
			ids = helpers.string.stripToIntegerArray(vals, { sort: true} );
			// return string
			if(arguments.length <= 0)
			{
				return ids.join(",");
			}
			// return as array
			if(needArray === true)
			{
				return ids;
			}
		},

		// reacts to selected project
		switchDisplayedCollection: function() 
		{
			// fetch id from displayed project
			var field = this.$projectSelection,
				id = parseInt(field.val(), 10),
				model = null;
			// avoid error by checking form fields is empty
			// if empty remove content
			if(id > 0) {
				model = this.collections.projects.get(id);
				// display in field
				this.displayUpdatedCollection( model.get("collection") );
			
			} else {
				this.$blockIdField.val("");

			}
			// update block ids with views
			this.setIncludedBlocks();
		},

		// displays collection string
		displayUpdatedCollection: function(ids)
		{
			if(Array.isArray(ids))
			{
				// sort and add to ids value field
				this.$blockIdField.val( helpers.array.sortByDigit(ids).join(", ") );
			
			} else if (typeof ids === "string")
			{
				// sort and add to ids value field
				this.$blockIdField.val( 
					helpers.array.sortByDigit( helpers.string.stripToArray(ids) ).join(", ")
				);
			}
		},

		addToProject: function(model)
		{
			var blockIds = this.getBlockIds(true),
				modelId = model.model.get("block_id");

			if(!_.contains(blockIds, modelId))
			{
				blockIds.push(modelId);
				this.displayUpdatedCollection(blockIds);
			}
		},

		// listens to an exclude event
		// and removes block from included blocks
		// if present
		removeFromProject: function(model)
		{	
			console.log("REMOVAL removeal received");

			var i,
				len,
				ids = this.getBlockIds(true),
				idToRemove = model.model.get("block_id");
			
			for(i = 0, len = ids.length; i < len; i+=1)
			{
				if(ids[i] === idToRemove)
				{
					ids.splice(i,1);
					i -= 1;
					break;
				}
			}
			this.displayUpdatedCollection(ids);
		},


		// fetch the projectsblocks from database
		// project block ids are saved as string in DB
		fetchProjectBlocks: function()
		{
			// warn of all blocks will be removed
			if(!window.confirm(MESSAGES.all_shown_blocks_will_be_removed)) {
				return;
			}
			
			// grab string from block field
			// fetch as array
			var ids = this.getBlockIds(true),
				_this = this;

			this.collections.blockEntries.trigger(this.CUSTEVENTS.prefetch,
			{
				id 		 			 : ids.join(";"),
				searchReplaceResults :  true,
				tag 	             : "",
				category 			 : ""
			});
		},

		// extends current text block selection
		// by all textblocks currently displayed in
		// the results pain
		extendProjectBlocks: function()
		{
			var oldProjectIds =  this.getBlockIds(true),
				blockColl = this.collections.blockEntries,
				newProjectIds = [];

			blockColl.each(function(model, index)
			{	
				// only include if model is not
				// set to hidden, means model was hidden in view
				if(!model.get("hidden"))
				{
					oldProjectIds.push(model.get("block_id"));
				}
			});
			// remove duplicates and sort the array
			newProjectIds = _.uniq(oldProjectIds);
			// pass in custom array to block update
			this.setIncludedBlocks(newProjectIds);
		},


		validateNewProject: function(projectName)
		{
			var $field 	= this.$newProjectId,
				val 	= $field.val().trim(),
				doubles = null;

			if(val === "") {
				$field.addClass(this.CSS.formError);
				return false;

			} else if (val !== "") {
				doubles = this.collections.projects.where({ "project_name" : projectName });
				if(doubles.length > 0) {
					$field.addClass(this.CSS.formError);
					alert(MESSAGES.project_name_exists);
					return false;
				
				} else {
					$field.removeClass(this.CSS.formError);
					return true;
				}
			}
		},

		getActiveProjectId: function()
		{
			return parseInt(this.$projectSelection.val(), 10);
		},

		// save the current selection to DB
		saveProject: function()
		{
			var _this = this;
			// ##new project
			if(this.newProjectInProgress === true)
			{
				var projectName = this.$newProjectId.val().trim();
				if( this.validateNewProject(projectName) === true ) {
					
					// add progress bar	
					this.router.inprogress(true);	
					// fetch data
					this.collections.projects
					.create(
					{
						project_name  : projectName,
						collection 	  : this.getBlockIds(), // fetch as string
					
					}, { 
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
					
					// set status of new project creation
					this.setNewProjectCreation();
					return;
				}
			}

			// ##existing project
			if(this.newProjectInProgress === false)
			{
				// fetch id from displayed project
				var id 	   	 = this.getActiveProjectId(),
					model  	 = null,
					// get block ids as tring
					blockIds = this.getBlockIds();
					
				// if no field val -> NULL is returned
				// AND blockids is not empty
				if( id > 0) {
					model = this.collections.projects.get(id);

					// add progress bar	
					this.router.inprogress(true);	

					// save model
					model.save({ 
						collection : this.getBlockIds() // fetch as string
					}, { 
						wait : true
					})
					.then(
						// success
						function() {						
							// notify user of saved 
							_this.router.actionSuccess();
							// remove progress bar	
							_this.router.inprogress(false);								
						},
						// fail
						function() {
							_this.router.actionError();
							// remove progress bar	
							_this.router.inprogress(false);	
						}
					);	
						
				} else {
					this.$blockIdField.val("");
								
				}
			}
		},

		// remove project from DB
		deleteProject: function()
		{
			if(!confirm(MESSAGES.delete_project)) {
				return;
			}

			// fetch id from displayed project
			var id 	  = this.getActiveProjectId(),
				model = null,
				_this = this;
			// avoid error by checking form fields is empty
			// if empty remove content
			if(id > 0) {
				// returns EMPTY array if not match is found
				model = this.collections.projects.get(id);
				
				// add progress bar	
				this.router.inprogress(true);	
				
				// destroy model
				// model will trigger a destroy event
				model
				 .destroy({ 
					wait : true 
				 })
				 .then(
				 // success
					function() {						
						// notify user of saved 
						_this.router.actionSuccess();
						// add progress bar	
						_this.router.inprogress(false);								
					},
					// fail
					function() {
						_this.router.actionError();
						// add progress bar	
						_this.router.inprogress(false);						
					}
				);

			} else {
				this.$blockIdField.val("");
				// update block ids with views
				this.setIncludedBlocks();
			}
		},

		// add ONE new user created entries
		addNewEntry: function(model)
		{
			var blockId = model.get("block_id");
			this.$newUserCreatedEntries.append( this.templateNewCreatedEntries({ block_id: blockId }));
		},

		// add new user created entries
		addNewEntries: function(model)
		{
			var _this = this,
				newEntries = this.collections.newEntries,
				lastFiveEntries = [],
				len = newEntries.length;

			if(len > 5) {
				// remove all previous created entries
				this.$newUserCreatedEntries.empty();
				// get the last five in the collection
				lastFiveEntries = newEntries.rest(len-5)
				// display the last five entries
				lastFiveEntries.forEach(function(model, index) {
					_this.addNewEntry(model);
				});
			// add each as long as new entries does not exceed 5 items	
			} else {
				_this.addNewEntry(model);
			}	
		},

		// fetches the newly created entries
		getNewCreatedEntry: function(e)
		{
			var id 	  = parseInt( $(e.currentTarget).text() ),
				_this = this;

			if(!window.confirm(MESSAGES.all_shown_blocks_will_be_removed)) {
				return;
			}

			this.collections.blockEntries.trigger(this.CUSTEVENTS.prefetch,
			{
				id 		: id,
				tag 	: "",
				category: "",
				searchReplaceResults :  true,
			});	
		}
	});

	return View_Projects;

});