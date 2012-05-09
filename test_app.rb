require "#{File.dirname(__FILE__)}/app"
require 'test/unit'
require 'rack/test'

ENV['RACK_ENV'] = 'test'

class AppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_no_redirect_on_root_domain
    get 'http://smidig2012.no/'
    assert !last_response.redirect?
  end

  def test_redirect_www_subdomain
    get 'http://www.smidig2012.no/'
    assert last_response.redirect?

    follow_redirect!

    assert_equal 'smidig2012.no', last_request.env['SERVER_NAME']
  end

  def test_no_redirect_other_subdomain
    get 'http://wwwww.smidig2012.no/'
    assert !last_response.redirect?
  end
end
