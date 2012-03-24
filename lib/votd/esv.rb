module Votd
  module ESV
    # Returns the Verse of the Day from http://www.esvapi.org/
    #
    # @param none
    # @return [JSON] verse of the day as a JSON string
    def self.votd
      File.read("spec/fixtures/votd.json")
    end
  end
end
