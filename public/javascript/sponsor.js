/*global jQuery: false*/
var smidig = smidig || {};

smidig.sponsor = function(){
	var fetch = function(container, uri) {
		jQuery.ajax(uri, {
			dataType: "jsonp",
			success: function(data) {
				container.html(data);
			}
		});
	};
	
	var init = function(base) {
		base = base || "";
		jQuery(function() {
			var container = jQuery(".sponsor-container"),
				uri = base + jQuery(".sponsor-container").data("uri");
			if(container.length !== 0 && uri) {
				fetch(container, uri)
			}
		});		
	};

	return {
		init: init
	};
}();