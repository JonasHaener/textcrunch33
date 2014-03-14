"use strict";


(function(window, $)
{

	var APP = window.APP || {};
	window.APP = APP;
	
	var FETCH = APP.FETCH = {},
	
	$searchBar = $(".js_search"),
	
	$submitButt = $(".js_submit"),
	
	$resultContainer = $(".js_result_cont"),
	
	result = {
		// match with data tags
		// assigned to on input
		category : [],
		tag	 	 : []
	},
		
	init = function()
	{
		$submitButt.on("click", collectTags);
	},
	
	collectTags = function(e)
	{
		var tags = $searchBar.children('span'),
			attr = "";
		$.each(tags, function(index, tag) {
			attr = tag.getAttribute("data-type");
			result[attr].push( tag.textContent );
		});
		displayResults(result);
	},
	
	displayResults = function()
	{
		$resultContainer.text( JSON.stringify(result) );	
	};

	// assign handler
	FETCH.init = init;
	
}(window, jQuery));
