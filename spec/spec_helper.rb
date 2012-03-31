require 'rspec'
require 'votd'
require 'fake_web'

FakeWeb.allow_net_connect = false

RSpec.configure do |config|
  config.mock_with :rspec

  def fixture(filename)
    File.join(File.dirname(__FILE__), 'fixtures', filename)
  end

  def read_fixture(filename)
    File.read(fixture(filename))
  end

  # Register Bible Gateway URI
  FakeWeb.register_uri(:get, Votd::BibleGateway::URI,
                       body: open(fixture("bible_gateway/bible_gateway.rss")))

  # Register NETBible URI
  FakeWeb.register_uri(:get, Votd::NetBible::URI,
                       body: open(fixture("netbible/netbible.json")))

  # Register broken uri
  def register_broken_uri(uri)
    FakeWeb.register_uri(:get, uri,
                         body: "Oopsies",
                         status: ["404", "Not Found"])
  end
end
