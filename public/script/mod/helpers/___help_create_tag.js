"use strict";

define(function(require) {
	
	var _ 		 	= require("underscore"),
		$		 	= require("jquery"),
		templTag	= require("text!mod/templates/tmpl_tag.html"),
 	
	tagging :
	{

		createTag : function(val, tagKind)
		{
			console.log("helper_create_tag: tag created");
			var template = _.template( templTag );
			return template(
			{
				text: val,
				tagClass: tagKind,
				dataTagType: tagKind
			});
		},

		isDuplicatedTag: function(allValues, tagVal)
		{
			var i,
				len,
				doubleFound = false;

			for(i = 0, len = allValues.length; i < len; i+=1)
			{
				if(allValues[i] === tagVal)
				{
					doubleFound = true;
				}
			}
			return doubleFound;
		}
	};

	return tagging;

});	