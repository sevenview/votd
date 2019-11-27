require 'votd/helper/text'

module Votd
  # Retrieves a Verse of the Day from http://bible.org using the NETBible
  # translation.
  class NetBible < Votd::Base
    # The name of the Bible Translation that this module generates
    BIBLE_VERSION = 'NETBible'
    BIBLE_VERSION_NAME = 'NET Bible'

    # The URI of the API gateway
    URI = "http://labs.bible.org/api/?passage=votd&type=json"

    # The URI of the website to view the verse (used in ``.link``)
    NET_BIBLE_URI = "https://netbible.org/bible"

    # Initializes the NetBible class
    # @return [Votd::NetBible]
    def initialize
      super
    end

    private
    # Gets the verse in JSON format from bible.org
    def get_votd
      netbible_data = JSON.parse(HTTParty.get(URI))

      # use bookname from first verse -- assume votd won't span books
      bookname = netbible_data[0]["bookname"]

      # use chapter from first verse -- assume votd won't span chapters
      chapter = netbible_data[0]["chapter"]

      # loop through each verse to get the verse numbers and verse text
      verse_numbers = Array.new
      verses        = Array.new
      netbible_data.each do |verse|
        verse_numbers << verse["verse"]
        verses        << verse["text"]
      end

      # now build the reference
      @reference = "#{bookname} #{chapter}:#{verse_numbers.join("-")}"

      # build the text
      text = Helper::Text.strip_html_tags(verses.join(" "))
      text = Helper::Text.clean_verse_start(text)
      text = Helper::Text.clean_verse_end(text)

      @text = text

      @version = BIBLE_VERSION
      @version_name = BIBLE_VERSION_NAME

      @link = generate_link(bookname, chapter, verse_numbers.first)

    rescue => e
      # use default info for VotD
      set_defaults
      # @todo Add logging
    end

    def generate_link(bookname, chapter, verse_number)
      "#{NET_BIBLE_URI}/#{bookname}+#{chapter}:#{verse_number}"
    end
  end
end
