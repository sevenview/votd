require "rspec"
require "votd"
require "webmock/rspec"

RSpec.configure do |config|
  config.mock_with :rspec
end

# Fixtures
def expand_fixture_path(filename)
  File.join(File.dirname(__FILE__), "fixtures", filename)
end

def read_fixture(filename)
  File.read(expand_fixture_path(filename))
end

# Register a fake URI
def fake_a_uri(uri, fixture_path)
  stub_request(:get, uri).to_return(body: read_fixture(fixture_path))
end

# Register a fake broken URI
def fake_a_broken_uri(uri)
  stub_request(:get, uri).to_return(body: "Oopsies")
end

RSpec.shared_examples "falls back to defaults" do
  it "falls back to default VotD values" do
    expect(votd.version).to eq Votd::Base::DEFAULT_BIBLE_VERSION
    expect(votd.reference).to eq Votd::Base::DEFAULT_BIBLE_REFERENCE
    expect(votd.text).to eq Votd::Base::DEFAULT_BIBLE_TEXT
  end
end
