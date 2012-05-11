require 'sinatra'
require 'haml'
require 'sass'

before do
  if request.host.start_with? "www."
    url = request.scheme + "://"
    url << request.host.sub(/^www\./, "")
    redirect to(url), 301
  end
end

get '/' do
  haml :index
end

get '/stylesheet/' do
  sass :css
end

__END__
@@ layout
!!! 5
%html(lang="no")
  %head
    %meta(charset="utf-8")
    %title Smidig 2012
  %body
    =yield


@@ css

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
