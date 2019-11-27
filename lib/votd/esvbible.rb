require 'votd/helper/text'

module Votd
  # Retrieves a Verse of the Day from http://www.gnpcb.org,
  # Good News Publishers, Crossway Bibles,
  # using the English Standard Version translation (ESV).
  class ESVBible < Votd::Base
    # The name of the Bible Translation that this module generates
    BIBLE_VERSION = "ESV"
    BIBLE_VERSION_NAME = "English Standard Version"

    # The URI of the API gateway
    URI = "http://www.gnpcb.org/esv/share/rss2.0/daily/"

    # Initializes the ESVBible class
    # @return [Votd::ESVBible]
    def initialize
      super()
    end

    private

    # Gets the votd from the Good News Publishers, Crossway Bibles,
    # RSS feed
    # @return [String]
    def get_votd
      parsed_feed       = Nokogiri::XML(HTTParty.get(URI).body)
      cleaned_copyright = clean_copyright(parsed_feed.xpath("//copyright").text)

      @reference = parsed_feed.xpath("//title")[1].text
      @text      = parsed_feed.xpath("//description")[1].text
      @copyright = cleaned_copyright
      @link      = parsed_feed.xpath("//guid").text
      @version   = BIBLE_VERSION
      @version_name = BIBLE_VERSION_NAME

      @text = Helper::Text.clean_verse_start(@text)
      @text = Helper::Text.clean_verse_end(@text)
    rescue => e
      # use default info for VotD
      set_defaults
    end

    # Cleans up the copyright.
    # Removes:
    #   - Tabs, line breaks
    # Inserts:
    #   - Missing space after commas
    # @return [String]
    def clean_copyright(text)
      text = text.gsub(/[\t\n]/, '')
      text = text.gsub(/,(?!\s)/, ', ')
    end
  end
end
