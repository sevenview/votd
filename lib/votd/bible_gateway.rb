require 'feedzirra'
module Votd
  # Retrieves a Verse of the Day from biblegateway.com using a variety
  # of translations.
  #
  # docs: http://www.biblegateway.com/usage/votd/docs/
  #
  # version list: http://www.biblegateway.com/usage/linking/versionslist.php
  #
  # @todo Extend this to allow requesting any of the supported Bible translations that
  #       Bible Gateway supports for VotD
  #
  class BibleGateway < Votd::Base
    # The name of the Bible Translation that this module generates
    BIBLE_VERSION = "NIV"

    # The URI of the API gateway
    URI = "http://www.biblegateway.com/usage/votd/rss/votd.rdf?"

    # Initializes the BibleGateway class
    def initialize
      super
    end

    private
    # @todo Generate default VotD from Votd::Base if there's a problem getting feed
    # Gets the votd from the Bible Gateway RSS feed
    def get_votd
      feed       = Feedzirra::Feed.parse(HTTParty.get(URI).body)
      entry      = feed.entries.first
      @reference = entry.title
      @text      = entry.content.strip
      @version   = BIBLE_VERSION
    end
  end
end
