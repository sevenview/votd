require 'json'

module Votd
  module NETBible
    # Returns the Verse of the Day from http://www.bible.org/
    #
    # @param none
    # @return [JSON] verse of the day as a JSON string
    def self.votd
      netbible_data = JSON.parse(File.read(fixture("netbible.json")))

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
      reference = "#{bookname} #{chapter}:#{verse_numbers.join("-")}"

      # build the text
      text = verses.join(" ")

      votd = Hash.new
      votd["reference"] = reference
      votd["text"]      = text
      votd["date"]      = Date.today
      votd["version"]   = "BIBLE.ORG"
      return votd.to_json
    end
  end
end
