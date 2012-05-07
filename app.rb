require 'sinatra'
require 'haml'
require 'sass'

get '/' do
  haml :index
end

get '/style.css' do
  sass :style
end

__END__
@@ index
!!! 5
%html(lang="no")
  %head
    %meta(charset="utf-8")
    %title Smidig 2012
    %link(rel="stylesheet" href="/style.css")
  %body
    .page
      %h1
        Smidig 2012

      %p
        5.-6. November, 2012 <br/>
        Radisson Blue Plaza, Oslo

      %ul
        %li
          %a(href="https://twitter.com/#!/smidig")
            @smidig på twitter
        %li
          %a(href="http://lanyrd.com/2012/smidig2012/")
            Smidig 2012 på Lanyrd.com
        %li
          %a(href="http://www.facebook.com/pages/Smidigkonferansen/102562453136427")
            Smidig på Facebook
        %li
          %a(href="http://www.linkedin.com/groups?mostPopular=&gid=963587")
            Smidig på LinkedIn
        %li
          %a(href="mailto:kontakt@smidig.no")
            kontakt@smidig.no


@@ style

body
  background-color: #110039
  color: #eee
  font-family: Helvetica, Arial, sans-serif
.page
  width: 50%
  margin: 0 auto
a:link, a:visited
  text-decoration: none
  color: #b1e038
a:hover
  text-decoration: underline
a:active
  color: #fff
ul
  list-style-type: none
  padding: 0
  margin: 0
li
  padding: 0.3em 0
  margin: 0
