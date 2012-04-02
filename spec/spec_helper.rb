require 'rspec'
require 'votd'
require 'webmock/rspec'

RSpec.configure do |config|
  config.mock_with :rspec
end

# Fixtures
def fixture_path(filename)
  File.join(File.dirname(__FILE__), 'fixtures', filename)
end

def read_fixture(filename)
  File.read(fixture_path(filename))
end

# Register a fake URI
def fake_a_uri(uri, fixture_data)
  stub_request(:get, uri).to_return(body: fixture_data)
end

# Register a fake broken URI
def fake_a_broken_uri(uri)
  stub_request(:get, uri).to_return(body: "Oopsies")
end
