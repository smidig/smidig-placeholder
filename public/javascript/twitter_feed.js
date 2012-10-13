/*
 * Simple twitter integration
 * Documentation: https://dev.twitter.com/docs/using-search
 */
var twitterConf = {
    element: "<li>",
    limit: 5,
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
        url = $(this).data("url"),
        show_user = $(this).data("showuser"),
        show_time = $(this).data("showtime"),
        limit = $(this).data("limit") || twitterConf.limit,
        reload = $(this).data("reload");

    $(container).empty();

    function successHandler(data) {
      if(data.results) {
        data = data.results;
      }

      $.each(data, function(idx, result) {
        if(idx > limit) {
          return;
        }
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
        var msg = $("<li>", {html: "Could not load tweets"});
        msg.appendTo(container);
    }

    function execute() {
        $.ajax({ 
          url: url, 
          cache: true,       
          data: "include_entities=true",
          dataType: "jsonp"
        }).then(successHandler, errorHandler);
    }

    if(reload) {
        execute();
        setInterval(execute, (reload * 1000));
    } else {
        execute();
    }

  });

});