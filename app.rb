require 'sinatra'
require 'haml'
require 'sass'


configure do
  set :html, :format => 'html5'
  set :sass, :views => 'sass'
end

configure :production do
  set :sass, :style => :compressed
end

configure :development do
  set :sass, :debug_info => true
end


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
  sass :stylesheet
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

