require 'rspec'
require 'votd'
require 'fake_web'

FakeWeb.allow_net_connect = false

RSpec.configure do |config|
  config.mock_with :rspec

  def fixture(filename)
    File.join(File.dirname(__FILE__), 'fixtures', filename)
  end

  FakeWeb.register_uri(:get, "http://labs.bible.org/api/?passage=votd&type=json",
                       body: open(fixture("netbible.json")))
end
