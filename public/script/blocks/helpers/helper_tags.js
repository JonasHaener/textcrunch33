"use strict";

define(function(require) {
	
	var _ 		 	= require("underscore"),
		$		 	= require("jquery"),
		templTag	= require("text!blocks/templates/tmpl_tag.html"),
 	
	tagging =
	{

		createTag : function(val, tagKind)
		{
			console.log("helper_create_tag: tag created");
			if(typeof val !== "string" && typeof tagKind !== "string")
			{
				throw "helper_tags: createTag : String expected";
			}
			var template = _.template( templTag );
			return template(
			{
				text: val,
				tagClass: tagKind,
				dataTagType: tagKind
			});
		},

		isDuplicatedTag: function(allValues, tagVal, hash)
		{
			var i,
				len,
				doubleFound = false;

			if(typeof tagVal !== "string")
			{
				throw "helper_tags: isDuplicatedTag : tagVal : String expected";
			}
			if(typeof allValues !== "object")
			{
				throw "helper_tags: isDuplicatedTag : allValues : Object expected";
			}

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