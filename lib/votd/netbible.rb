module Votd
  # Retrieves a Verse of the Day from bible.org using the NETBible
  # translation.
  class NetBible
    # The name of the Bible Translation that this module generates
    BIBLE_VERSION = "NETBible"

    # The URI of the API gateway
    URI = "http://labs.bible.org/api/?passage=votd&type=json"

    # Initializes the NetBible class
    def initialize
      @reference, @text = ""
      get_verse
    end

    # @macro [new] votd.reference
    # @example
    #    votd.reference  # "Ephesians 2:8-9"
    #
    # @return [String] the scripture reference.
    def reference
      @reference
    end

    # @macro [new] votd.text
    # @example
    #   votd.text  # "For by grace you are saved through faith..."
    # @return [String] the full bible passage
    def text
      @text
    end

    # @macro [new] votd.date
    # @example
    #   votd.date  # "2012-03-24"
    #
    # @return [String] the date the Verse was retrieved
    def date
      Date.today
    end

    # For this module this will always be:
    #   "NETBible"
    # @macro [new] votd.version
    # @return [String] the bible translation used for this VotD
    def version
      BIBLE_VERSION
    end

    # @macro [new] votd.to_html
    # Returns the Verse of the Day formatted as HTML. e.g.
    #    <p class="votd-text">For by grace you are saved through faith...</p>
    #    <p>
    #    <span class="votd-reference"><strong>Ephesians 2:8-9</strong></span>
    #    <span class="votd-version"><em>(NETBible)</em></span>
    #    </p>
    #
    # This should provide sufficient hooks to style the CSS. If this is not
    # sufficient, you can build the HTML by hand using the individual data.
    #
    # @return [String] the VotD formatted as HTML
    def to_html
      html =  "<p class=\"votd-text\">#{self.text}</p>\n"
      html << "<p>\n"
      html << "<span class=\"votd-reference\"><strong>#{self.reference}</strong></span>\n"
      html << "<span class=\"votd-version\"><em>(#{self.version})</em></span>\n"
      html << "</p>\n"
      html
    end

    private
    # Gets the verse in JSON format from bible.org
    def get_verse
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
      @text = verses.join(" ")
    end
  end
end
