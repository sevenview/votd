# frozen_string_literal: true

module Votd
  # Retrieves a Verse of the Day from https://labs.bible.org using the NETBible
  # translation.
  class NetBible < Votd::Base
    # The name of the Bible Translation that this module generates
    BIBLE_VERSION = "NETBible"
    BIBLE_VERSION_NAME = "NET Bible"

    # The URL of the API gateway
    ENDPOINT_URL = "https://labs.bible.org/api/?passage=votd&type=json"

    # The URL of the website to view the verse (used in ``.link``)
    NET_BIBLE_URL = "https://netbible.org/bible"

    private

    # Gets the verse in JSON format from bible.org
    def get_votd
      netbible_data = JSON.parse(HTTParty.get(ENDPOINT_URL))

      # use bookname from first verse -- assume votd won't span books
      bookname = netbible_data[0]["bookname"]

      # use chapter from first verse -- assume votd won't span chapters
      chapter = netbible_data[0]["chapter"]

      verse_numbers = netbible_data.map { |v| v["verse"] }
      verses = netbible_data.map { |v| v["text"] }

      # now build the reference
      @reference = "#{bookname} #{chapter}:#{verse_numbers.first}"
      @reference += "-#{verse_numbers.last}" if verse_numbers.size > 1

      # build the text
      text = Helper::Text.strip_html_tags(verses.join(" "))
      text = Helper::Text.clean_verse_start(text)
      text = Helper::Text.clean_verse_end(text)

      @text = text

      @version = BIBLE_VERSION
      @version_name = BIBLE_VERSION_NAME

      @link = generate_link(bookname, chapter, verse_numbers.first)
    rescue => e
      report_and_raise(e, "Failed to fetch verse from NetBible")
    end

    def generate_link(bookname, chapter, verse_number)
      "#{NET_BIBLE_URL}/#{bookname}+#{chapter}:#{verse_number}"
    end
  end
end
