require 'sinatra'
require 'haml'
require 'sass'
require 'yaml'


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
    YAML::load( File.open("sponsors.yml") )
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

get '/stylesheet' do
  sass :stylesheet
end
