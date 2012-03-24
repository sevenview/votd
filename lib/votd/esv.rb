module Votd
  class ESV
    # Returns the Verse of the Day from http://www.esvapi.org/
    #
    # @param none
    # @return [JSON] verse of the day as a JSON string
    def votd
      File.read(fixture("votd.json"))
    end
  end
end
