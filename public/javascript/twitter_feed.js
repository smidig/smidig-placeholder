/*
 * Simple twitter integration
 * Documentation: https://dev.twitter.com/docs/using-search
 */
var twitterConf = {
    element: "<li>",
    limit: 10,
    url: "http://search.twitter.com/search.json",
    parseURL: function(str) {
        return str.replace(/[A-Za-z]+:\/\/[A-Za-z0-9-_]+\.[A-Za-z0-9-_:%&~\?\/.=]+/g, function(url) {
            return url.link(url);
        });
    },
    parseUsername: function(str) {
        return str.replace(/[@]+[A-Za-z0-9-_]+/g, function(u) {
            var username = u.replace("@", "")
            return u.link("http://twitter.com/" + username);
        });
    },
    parseHashtag: function(str) {
        return str.replace(/[#]+[A-Za-z0-9-_]+/g, function(t) {
            var tag = t.replace("#", "%23")
            return t.link("http://search.twitter.com/search?q=" + tag);
        });
    }
};

$(function() {
  $(".twitter").each(function() {
    var container = $(this),
        query = $(this).data("query"),
        show_user = $(this).data("showuser"),
        show_time = $(this).data("showtime");

    function successHandler(data) {
      $(container).empty();
      $.each(data.results, function(idx, result) {
        var text = twitterConf.parseUsername(twitterConf.parseHashtag(twitterConf.parseURL(result.text)));
        var user = twitterConf.parseUsername("@"+result.from_user);
        var time = $.format.date(new Date(result.created_at), "dd/MM/yyyy");
        var time_str = show_time ? "<span class='time'>"+ time + "</span> <br />" : "";
        var user_str = show_user ? "<span class='user'>" + user + "</span>: " : "";
        var tweet = $(twitterConf.element, {html: time_str +  user_str + text});
        tweet.appendTo(container);
      });
    }

    function errorHandler() {
        $(container).empty();
        var msg = $("<li>", {html: "Could not load tweets"});
        msg.appendTo(container);
    }
    
    $.ajax({ 
      url: twitterConf.url, 
      cache: true, 
      data: "rpp=" + twitterConf.limit + "&q="+ query, dataType: "jsonp" 
    }).then(successHandler, errorHandler);

  });

});