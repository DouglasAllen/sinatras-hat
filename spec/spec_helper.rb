ARGV.clear

$LOAD_PATH << File.join(File.dirname(__FILE__), '..')

require 'rubygems'
require 'spec'
require 'rr'
require 'sinatra/base'
require 'sinatra/test'
require 'sinatra/test/rspec'

# What we're testing:
require 'lib/sinatras-hat'

# Fixture models/views:
require 'spec/fixtures/lib/abstract'
require 'spec/fixtures/lib/comment'
require 'spec/fixtures/lib/article'

def fixture(path)
  File.join(File.dirname(__FILE__), 'fixtures', path)
end

Spec::Runner.configure do |config|
  config.mock_with :rr
  config.include Sinatra::Test
end

def new_maker(klass=Article, *args, &block)
  Sinatra::Hat::Maker.new(klass, *args, &block)
end

def fake_request(options={})
  app = Sinatra.new
  app.set :views, fixture("views")
  request = app.new
  stub(request).params.returns(options)
  request
end

