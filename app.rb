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

get '/stylesheet' do
  sass :css
end

__END__
@@ layout
!!! 5
%html(lang="no")
  %head
    %meta(charset="utf-8")
    %title Smidig 2012
    %link(rel="stylesheet" href="/stylesheet")
  %body
    =yield


@@ css
@import url(http://fonts.googleapis.com/css?family=Open+Sans:400,700)
@mixin normal-font
  font-family: 'Open Sans', sans-serif
  font-weight: 400
@mixin bold-font
  font-family: 'Open Sans', sans-serif
  font-weight: 700

body
  background-color: #000
  color: #eee
  @include normal-font
