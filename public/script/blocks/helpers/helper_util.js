"use strict";

define(function(require) {
	
	var utils = {
		
		array: {
			sortByDigit : function(array)
			{
				return array.sort(function(a, b)
				{
					if(a < b) {
						return -1;
					} else if(a > b) {
						return 1;
					} else {
						return 0;
					}
				});
			}
		},
		
		string: {
			stripToArray: function(string)
			{
				var arr = string.split(",");
				arr.forEach(function(item, index) {
					arr[index] = item.trim().replace(/\s+/, "");
				});	
				return arr;
			},
			stripToIntegerArray: function(string, options)
			{
				var arr = string.split(","),
					resArr = [];
				
				arr.forEach(function(item, index) {
					var i = item.trim();
					if(!isNaN(i) && i !== "") {
						resArr.push( parseInt(i, 10) ) ;
					}
				});

				return (options.sort === true) ? utils.array.sortByDigit(resArr) : resArr;				
			}

		}
	}

	return utils;

});	