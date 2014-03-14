"use strict";


(function(window, $)
{

	var APP = window.APP || {};
	window.APP = APP;
	
	var TAGGING = APP.TAGGING = {};

	// layout hooks
	var layout = 
	{
		parent: $(".js_tagger"),
		search: $(".js_search"),
		cats: 	$(".js_cats"),
		tags: 	$(".js_tags")
	},

	createTemplate = function(cont)
	{
		var ele = window.document.createElement('span');
		ele.innerHTML = cont;
		return ele;
	},

	// assign listeners
	init = function()
	{
		layout.parent.on("keypress", ".js_cats", addValues);
		layout.parent.on("keypress", ".js_tags", addValues);
		layout.parent.on("dblclick", ".js_search span", removeItem);
	},

	verify = function(val)
	{
		if(val !== "")
		{
			return true;
		
		} else
		{
			return false;
		}
	},

	manageSearch = function(val, kind)
	{
		var newEle = createTemplate(val),
			existEles = layout.search.children();
		newEle.classList.add("egg-face-" + kind);
		newEle.setAttribute("data-type", kind);
		layout.search.append(newEle);
	},

	// add values from form fields
	addValues = function(e)
	{
		if(e.which !== 13) { return; }

		var target 	= e.currentTarget,
			kind 	= target.getAttribute("data-kind"),
			val 	= target.value.trim();

		if(verify( val ) !== true)
		{ 
			return; 
		}
		// kind corresponds to a class name
		manageSearch(val, kind);
		target.value = "";
	},

	// remove item from field
	removeItem = function(e)
	{
		$(e.currentTarget).remove();
	};

	TAGGING.init = init;

}(window, jQuery));


