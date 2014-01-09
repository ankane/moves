require 'rspec'
require "webmock/rspec"
require "json"

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def stub_get(path)
  stub_request(:get, Regexp.new(Moves::Client::ENDPOINT + path))
end

def fixture(name)
  File.open('spec/fixtures/' + name).read
end

RSpec::Matchers.define :be_a_valid_response do |expected|
  match do |actual|
    actual.size >= 1
  end
end
