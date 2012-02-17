require File.expand_path("../../lib/facebookparser",__FILE__)
require 'httparty'
require 'vcr'

#Support files
Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}

RSpec.configure do |config|
end

VCR.config do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.stub_with :webmock
end