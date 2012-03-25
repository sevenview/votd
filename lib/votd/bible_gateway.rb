module Votd
  # Retrieves a Verse of the Day from biblegateway.com using a variety
  # of translations.
  class BibleGateway
    # Initializes the BibleGateway class
    def initialize
      @reference =  "1 John 1:9"
      @text = ""
    end

    # @macro votd.date
    def date
      Date.today
    end

    # @macro votd.reference
    def reference
      @reference
    end

  end
end
