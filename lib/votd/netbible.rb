require 'votd/helper'

module Votd
  # Retrieves a Verse of the Day from http://bible.org using the NETBible
  # translation.
  class NetBible < Votd::Base
    # The name of the Bible Translation that this module generates
    BIBLE_VERSION = "NETBible"

    # The URI of the API gateway
    URI = "http://labs.bible.org/api/?passage=votd&type=json"

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
      #text = strip_html_tags(verses.join(" "))
      text = Helper::Text.strip_html_tags(verses.join(" "))
      text = clean_verse_start(text)
      text = clean_verse_end(text)

      @text = text

      @version = BIBLE_VERSION

    rescue => e
      # use default info for VotD
      set_defaults
      # @todo Add logging
    end
  end
end
