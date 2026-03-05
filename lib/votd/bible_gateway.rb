# frozen_string_literal: true

require "feedjira"

module Votd
  # Retrieves a Verse of the Day from biblegateway.com using a variety
  # of translations.
  #
  # Default translation is NIV (New International Version)
  #
  # docs: https://www.biblegateway.com/usage/votd/docs/
  #
  # version list: https://www.biblegateway.com/usage/linking/versionslist.php

  class BibleGateway < Votd::Base
    # These are the English translations that are copyright-approved for Bible
    # Gateway VotD as of November 2019.
    BIBLE_VERSIONS = {
      amp: {name: "Amplified Bible", id: 45},
      asv: {name: "American Standard Version", id: 8},
      ceb: {name: "Common English Bible", id: 105},
      darby: {name: "Darby Translation", id: 16},
      esv: {name: "English Standard Version", id: 47},
      esvu: {name: "English Standard Version Anglicised", id: 166},
      gw: {name: "God's Word Translation", id: 158},
      hcsb: {name: "Holman Christian Standard Bible", id: 77},
      kjv: {name: "King James Version", id: 9},
      leb: {name: "Lexham English Bible", id: 165},
      nasb: {name: "New American Standard Bible", id: 49},
      nirv: {name: "New International Reader's Version", id: 76},
      niv: {name: "New International Version", id: 31},
      nivuk: {name: "New International Version - UK", id: 64},
      nlt: {name: "New Living Translation", id: 51},
      nlv: {name: "New Life Version", id: 74},
      phillips: {name: "J.B. Phillips New Testament", id: 164},
      we: {name: "Worldwide English (New Testament)", id: 73},
      wyc: {name: "Wycliffe Bible", id: 53},
      ylt: {name: "Young's Literal Translation", id: 15}
    }

    # The URL of the API gateway
    ENDPOINT_URL = "https://www.biblegateway.com/usage/votd/rss/votd.rdf?"

    # Regular expression for pulling the copyright out of the Bible text
    COPYRIGHT_TEXT_REGEX = /(Brought to you by BibleGateway.*$)/

    # Initializes the BibleGateway class
    # @return [BibleGateway]
    def initialize(version = :niv)
      raise InvalidBibleVersion unless BIBLE_VERSIONS.key?(version)

      @version = version.to_s.upcase
      @version_number = BIBLE_VERSIONS[version][:id]
      @version_name = BIBLE_VERSIONS[version][:name]
      super()
    end

    private

    # Gets the votd from the Bible Gateway RSS feed
    # @return [String]
    def get_votd
      url = "#{ENDPOINT_URL}#{@version_number}"
      feed = Feedjira.parse(HTTParty.get(url).body)
      entry = feed.entries.first

      stripped = strip_html_quote_entities(entry.content)
      stripped = Helper::Text.strip_html_tags(stripped)

      @reference = entry.title
      @link = entry.entry_id
      @text = build_verse_text(stripped)
      @copyright = extract_copyright(stripped)
    rescue => e
      report_and_raise(e, "Failed to fetch verse from BibleGateway")
    end

    # Builds clean verse text from HTML-stripped content
    # @return [String]
    def build_verse_text(stripped)
      text = strip_copyright_text(stripped).strip
      text = Helper::Text.clean_verse_start(text)
      Helper::Text.clean_verse_end(text)
    end

    # Extracts copyright tag from HTML-stripped content
    # @return [String, nil]
    def extract_copyright(stripped)
      match = stripped.match(COPYRIGHT_TEXT_REGEX)
      match ? match[1] : nil
    end

    # Removes HTML quote entities added by BibleGateway
    # @return [String]
    def strip_html_quote_entities(text)
      text.gsub(/&[lr]dquo;/, "")
    end

    # Removes copyright text from the Bible text
    # @return [String]
    def strip_copyright_text(text)
      text.gsub(COPYRIGHT_TEXT_REGEX, "")
    end
  end
end
