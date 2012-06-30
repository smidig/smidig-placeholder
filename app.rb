require 'sinatra'
require 'haml'
require 'sass'
require 'yaml'
require 'sinatra/jsonp'


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

helpers do
  def partial(template, *args)
    template_array = template.to_s.split('/')
    template = template_array[0..-2].join('/') + "/_#{template_array[-1]}"
    options = args.last.is_a?(Hash) ? args.pop : {}
    options.merge!(:layout => false)
    haml(:"#{template}", options)
  end

  def sponsors
    YAML::load( File.open("sponsors.yml") ).shuffle
  end
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

get '/faq' do
  haml :faq, :layout => true
end

get '/sponsors' do
  data = haml :sponsors, :layout => false
  JSONP data
end

get '/stylesheet' do
  sass :stylesheet
end

get '/*.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass params[:splat].join.to_sym
end
