require_relative "../app"
require "rspec"
require "rack/test"

set :environment, :test

include Rack::Test::Methods

def app
  Sinatra::Application
end

def json_spec_response
  JSON.parse(last_response.body)
end
