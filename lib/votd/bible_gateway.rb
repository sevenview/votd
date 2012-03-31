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
    # @return [BibleGateway]
    def initialize
      # Regular expression for pulling the copyright out of the Bible text
      @regex_copyright_text = /(Brought to you by BibleGateway.*$)/
      super
    end

    private

    # Gets the votd from the Bible Gateway RSS feed
    # @return [String]
    def get_votd
      feed         = Feedzirra::Feed.parse(HTTParty.get(URI).body)
      entry        = feed.entries.first
      cleaned_text = clean_text(entry.content)

      @reference   = entry.title
      @text        = cleaned_text
      @copyright   = get_copyright(entry.content)
      @version     = BIBLE_VERSION
    rescue
      # use default info for VotD
      set_defaults
      # @todo Add logging
    end

    # Cleans up the text. Removes:
    #   - HTML quote entities
    #   - HTML tags
    #   - Copyright text
    #   - Extra spaces, line breaks, etc.
    # @return [String]
    def clean_text(text)
      text = strip_html_quote_entities(text)
      text = strip_html_tags(text)
      text = strip_copyright_text(text)
      text.strip
    end

    # Extracts copyright tag from the Bible text
    # @return [String]
    def get_copyright(text)
      text = strip_html_quote_entities(text)
      text = strip_html_tags(text)
      text.match(@regex_copyright_text)[1]
    end

    # Removes HTML quote entities added by BibleGateway
    # @return [String]
    def strip_html_quote_entities(text)
      text.gsub(/&.dquo;/, '')
    end

    # Removes HTML tags from the Bible text
    # @return [String]
    def strip_html_tags(text)
      text.gsub(/<\/?[^>]*>/, '')
    end

    # Removes copyright text from the Bible text
    # @return [String]
    def strip_copyright_text(text)
      text.gsub(@regex_copyright_text, '')
    end
  end
end
