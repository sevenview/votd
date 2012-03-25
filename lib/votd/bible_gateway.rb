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
  class BibleGateway
    # The name of the Bible Translation that this module generates
    BIBLE_VERSION = "NIV"

    # The URI of the API gateway
    URI = "http://www.biblegateway.com/usage/votd/rss/votd.rdf?"

    # Initializes the BibleGateway class
    def initialize
      @reference =  ""
      @text = ""
      get_verse
    end

    # @macro votd.date
    def date
      Date.today
    end

    # @macro votd.reference
    def reference
      @reference
    end

    # @macro votd.text
    def text
      @text
    end

    # @macro votd.version
    def version
      BIBLE_VERSION
    end

    # @macro votd.to_html
    def to_html
      html =  "<p class=\"votd-text\">#{self.text}</p>\n"
      html << "<p>\n"
      html << "<span class=\"votd-reference\"><strong>#{self.reference}</strong></span>\n"
      html << "<span class=\"votd-version\"><em>(#{self.version})</em></span>\n"
      html << "</p>\n"
      html
    end

    private
    # Gets the votd from the Bible Gateway RSS feed
    def get_verse
      feed = Feedzirra::Feed.parse(HTTParty.get(URI).body)
      entry = feed.entries.first
      @reference = entry.title
      @text      = entry.content.strip
    end

  end
end
