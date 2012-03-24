require 'rspec'
require 'votd'

RSpec.configure do |config|
  config.mock_with :rspec

  def fixture(filename)
    File.join(File.dirname(__FILE__), 'fixtures', filename)
  end
end
