/* Backbone chield views management */
"use strict";

define(function(require) {

	var	_ 					= require("underscore"),
		$ 					= require("jquery"),	
		Backbone 			= require("backbone"),
		View_MainNavi		= require("views/v_stats_main_navi"),
		View_Category		= require("views/v_stats_categories"),
		View_Users			= require("views/v_stats_users"),
		View_Tags			= require("views/v_stats_tags"),
		View_Blocks			= require("views/v_stats_blocks"),
		View_Import			= require("views/v_stats_import"),
		View_Footer			= require("views/v_mFooter"),

		Collection_Other	= require("collections/c_stats_other"),
		Collection_Users 	= require("collections/c_stats_users"),
		// uses to route messages
		Message_Router		= require("routers/r_stats_router"),


	// App view
	View_app = Backbone.View.extend({

		el: "#js_mApp",
		
		mainNaviContainer 	: $("#js_mAppNavi"),
		contentContainer	: $("#js_mContent"),
		statistics 			: $("#js_mStatistics"),
		footer 				: $("#js_mFooter"),

		tempViews: {
			mainNavi : {},
			statistics : {},
			footer: {}
		},

		// keep reference fro cleaning up
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
			// user stats (set in initialize)
			// other stats (set in initialize)
		},

		CUSTEVENTS:
		{
			getStats: "getStats"
		},
		
		CSS: {

		},
		
		initialize: function() {
			// users
			this.collections.users = new Collection_Users();
			// All Other statistics
			this.collections.other = new Collection_Other();
			// message router 
			this.router = new Message_Router();
			// prepare all childviews
			this.prepChildViews();
			// trigger stats retrieval for other stats
			// users stats are fetched from users view
			this.listenTo(this.router, this.CUSTEVENTS.getStats, this.getStatistics);
		},

		assignHooks: function()
		{

		},

		prepChildViews: function() {
			// main navi
			var appNavi = this.views.appNavi = new View_MainNavi();
			this.tempViews.mainNavi[ appNavi.cid ] = appNavi;
			appNavi.router = this.router;
		
			// users 
			var users = this.views.users = new View_Users();
			this.tempViews.statistics[ users.cid ] = users;
			users.setForeignCollection({ 
				users  : this.collections.users,
			});
			users.router = this.router;
		
			// tags 
			var tags = this.views.tags = new View_Tags();
			this.tempViews.statistics[ tags.cid ] = tags;
			tags.setForeignCollection({ 
				other  : this.collections.other 
			});
			tags.router = this.router;
			
			// blocks
			var blocks = this.views.blocks = new View_Blocks();
			this.tempViews.statistics[ blocks.cid ] = blocks;
			blocks.setForeignCollection({ 
				other  : this.collections.other
			});
			blocks.router = this.router;
						
			// categories 
			var categories = this.views.categories = new View_Category(); 
			this.tempViews.statistics[ categories.cid ] = categories;
			categories.setForeignCollection({ 
				other 	: this.collections.other
			});
			categories.router = this.router;

			// data import 
			var dataImport = this.views.dataImport = new View_Import(); 
			this.tempViews.statistics[ dataImport.cid ] = dataImport;
			dataImport.setForeignCollection({ 
				other 	: this.collections.other
			});
			dataImport.router = this.router;

			// footer
			var footer = this.views.footer = new View_Footer();
			this.tempViews.footer[ footer.cid ] = footer;

			//append fake views to DOM
			this.mainNaviContainer.append( this.fakeChildViews(this.tempViews.mainNavi) );
			this.statistics.append( this.fakeChildViews(this.tempViews.statistics) );
			this.footer.append( this.fakeChildViews(this.tempViews.footer) );
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

		render: function() {
			this.renderChildViews();
		},

		fetchEntries: function(collection, configs)
		{
			this.router.inprogress(true);
			collection.fetch(configs);
		},


		// user stats controlled by user stats view
		getStatistics: function()
		{
			var _this = this,

				configs = {
				
				data: { other_stats : true },

				//remove: false,

				//reset: true,
				
				success: function(collection, response, options)
				{
					if(response.length > 0) {
						// if no records are found GET HTTP response is 204 -> no error
						_this.router.actionSuccess();
					
					} else {
						_this.router.actionError();
					}
				},
				
				error: function(collection, response, options)
				{
					// alert error
					_this.router.actionError();
				}
			};
			
			this.fetchEntries(this.collections.other, configs);
		}

	});

	return View_app;

});