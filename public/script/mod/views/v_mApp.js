/* Backbone chield views management */
"use strict";

define(function(require) {

	var	_ 					= require("underscore"),
		$ 					= require("jquery"),	
		Backbone 			= require("backbone"),
		View_AppNavi 		= require("mod/views/v_mAppNavi"),
		View_Results 		= require("mod/views/v_mResults"),
		View_Projects 		= require("mod/views/v_mProjects"),
		View_SearchStats 	= require("mod/views/v_mSearchStats"),
		View_SearchSettings = require("mod/views/v_mSearchSetting"),
		View_Footer			= require("mod/views/v_mFooter"),
		View_EntryForm		= require("mod/views/v_mEntryForm"),
		// Collection_Entries used as 
		// a global collection
		Collection_Entries		= require("mod/collections/c_mSearchSetting"),
		Collection_CatsAndTags 	= require("mod/collections/c_mCatsAndTags"),
		Collection_NewEntries   = require("mod/collections/c_mEntry"),
		Collection_PrefetchEntries = require("mod/collections/c_mPreEntry"),
		// uses to route messages
		Message_Router			= require("mod/routers/r_router"),


	// App view
	View_app = Backbone.View.extend({

		el: "#js_mApp",

		mainNaviContainer 	: $("#js_mAppNavi"),
		contentContainer	: $("#js_mContent"),
		rightColContainer 	: $("#js_col_right"),
		leftColContainer 	: $("#js_col_left"),
		footer 				: $("#js_mFooter"),

		tempViews: {
			mainNavi : {},
			rightCol : {},
			leftCol: {},
			footer: {}
		},

		views: {},
		
		cleanUp: function()
		{
			console.log("cleanup called");
			var i,
				views = this.views;
			//cleanup subviews
			for(i in views) {
				views[i].close();
			}
			//this main views
			this.close();

			console.log("CLOSE COMPLETE");
		},

		// cleanup Events view
		onClose: function()
		{
			console.log("cleanup runs in view onClose");
			// unbind all event handlers
			this.views = this.collections = this.router = null;
		},

		router: null,

		collections: {
			// blockEntries (set in initialize)
			// catsAndTags (set in initialize)
		},

		CUSTEVENTS:
		{
			tagsAndCatsLoaded	: "tagsAndCatsLoaded",
			updateComplete		: "updateComplete",
			updateError  		: "updateError",
			refreshTags 	    : "refreshTags"
		},
		
		CSS: {
			confirmMessage	: "egg-face-confirm-backgr",
			errorMessage  	: "egg-face-error-backgr"
		},
		
		initialize: function() {
			// blockEntries holds collections
			// for sharing
			this.collections.blockEntries = new Collection_Entries();
			// sharing
			this.collections.catsAndTags = new Collection_CatsAndTags();
			// message routing
			this.collections.newEntries  = new Collection_NewEntries();
			// prefetch entries
			this.collections.preFetchEntries = new Collection_PrefetchEntries();
			// message router 
			this.router = new Message_Router();
			// prepare all childviews
			this.prepChildViews();
			// refresh tags and cats
			this.listenTo(this.collections.catsAndTags, this.CUSTEVENTS.refreshTags, this.fetchCategoriesAndTags)
		},

		prepChildViews: function() {
			// ##App Navi
			var appNavi = this.views.appNavi = new View_AppNavi();
			this.tempViews.mainNavi[ appNavi.cid ] = appNavi;
			appNavi.setForeignCollection({ 
				blockEntries  : this.collections.blockEntries
			});
			appNavi.router = this.router;
		
			// ##EntryForm
			var entryForm = this.views.entryForm = new View_EntryForm();
			this.tempViews.leftCol[ entryForm.cid ] = entryForm;
			entryForm.setForeignCollection({ 
				catsAndTags  : this.collections.catsAndTags,
				newEntries   : this.collections.newEntries

			});
			entryForm.router = this.router;
		
			// ##Results 
			var results = this.views.results = new View_Results();
			results.setForeignCollection({ 
				blockEntries : this.collections.blockEntries,
				catsAndTags  : this.collections.catsAndTags 
			});
			results.router = this.router;
			this.tempViews.leftCol[ results.cid ] = results;

		
			// ##SearchSettings
			var searchSett = this.views.searchSett = new View_SearchSettings();
			// pass in block entry collection
			searchSett.setForeignCollection({ 
				blockEntries : this.collections.blockEntries,
				catsAndTags  : this.collections.catsAndTags,
				prefetchEntries : this.collections.preFetchEntries
			});
			searchSett.router = this.router;
			// assign temp view
			this.tempViews.rightCol[ searchSett.cid ] = searchSett;
			

			// ##Projects 
			var projects = this.views.projects = new View_Projects(); 
			this.tempViews.rightCol[ projects.cid ] = projects;
			projects.setForeignCollection({ 
				blockEntries: this.collections.blockEntries,
				newEntries 	: this.collections.newEntries
			});
			projects.router = this.router;

			// ##SearchStats 
			//var searchStats = this.views.searchStats = new View_SearchStats(); 
			//this.tempViews.rightCol[ searchStats.cid ] = searchStats;
			
			// ##Footer
			var footer = this.views.footer = new View_Footer();
			this.tempViews.footer[ footer.cid ] = footer;
		},

		fakeChildViews: function(childViews) {
			// create fragment
			var docFrag = document.createDocumentFragment();
			// loop all child views and create placeholder with "data-view-cid"
			_.each(childViews, function(view, cid) {
				var ele = document.createElement('div');
				ele.setAttribute('data-view-cid', cid);
				docFrag.appendChild(ele);
			});
			return docFrag;
		},

		renderChildViews: function() {
			// assign views according to their cid placeholders
			var n, 
				c = 0,
				_this = this,
				keys = Object.keys(this.tempViews),
				len = keys.length,
				// gradual attachment to DOM
			render = function(n) {
				_.each(_this.tempViews[n], function(view, cid) {
					_this.$('[data-view-cid="' + cid + '"]').replaceWith( view.render().el );
				}, _this);
			};	
			// render views
			while(c < len) {
				render(keys[c]);
				c++;	
			}	
		},

		setAppData: function()
		{
			this.$("#user").text(window.APP.user);
	
		},
		
		fetchCategoriesAndTags: function()
		{
			var _this = this;

			this.collections.catsAndTags.fetch(
			{	
				success: function(collection, response, options)
				{
					// trigger loaded event
					_this.collections.catsAndTags.trigger(_this.CUSTEVENTS.tagsAndCatsLoaded);
					_this.router.tagsLoaded(true);	
				},
		
				error: function(collection, response, options)
				{
					_this.router.tagsLoaded(false);	
				}
			});
		},
		
		render: function() {
			//append child views to DOM
			this.mainNaviContainer.append( this.fakeChildViews(this.tempViews.mainNavi) );
			this.rightColContainer.append( this.fakeChildViews(this.tempViews.rightCol) );
			this.leftColContainer.append( this.fakeChildViews(this.tempViews.leftCol) );
			this.footer.append( this.fakeChildViews(this.tempViews.footer) );
			this.renderChildViews();
			// set the notication DOM element
			//this.router.setNotifierElement();			
			// fetch categories and tags from DB
			this.fetchCategoriesAndTags();
			// set App date
			this.setAppData();
		}
	});

	return View_app;

});