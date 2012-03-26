module Votd
  # This is the base class that all Votd lookup modules inherit from.
  # It provides default values for the Votd in the event of lookup failure.
  # Child classes should override the {#get_votd} method to implement their
  # specific lookup function.
  class Base
    # @example
    #   votd.text  # "For by grace you are saved through faith..."
    # @return [String] the full bible passage
    attr_reader :text

    # @example
    #    votd.reference  # "Ephesians 2:8-9"
    #
    # @return [String] the scripture reference.
    attr_reader :reference

    # @example
    #   votd.date  # "2012-03-24"
    #
    # @return [String] the date the Verse was retrieved
    attr_reader :date

    # @example
    #     votd.version  # "NIV"
    # @return [String] the bible translation used for this VotD
    attr_reader :version

    # The default Bible version to use if none is given and no other default
    # is provided
    DEFAULT_BIBLE_VERSION = "KJV"

    # Initializes the class and retrieves the verse of the day.
    def initialize
      @text      = ""
      @reference = ""
      @date      = Date.today
      get_votd
    end

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
      html =  "<p class=\"votd-text\">#{@text}</p>\n"
      html << "<p>\n"
      html << "<span class=\"votd-reference\"><strong>#{@reference}</strong></span>\n"
      html << "<span class=\"votd-version\"><em>(#{@version})</em></span>\n"
      html << "</p>\n"
      html
    end

    protected
    # Gets the VotD. For base class this will return default values and can be
    # used in the event of an exception thrown in the subclassed modules.
    def get_votd
      @text      = "For God so loved the world, that he gave his only begotten Son, that whosoever believeth in him should not perish, but have everlasting life."
      @reference = "John 3:16"
      @version   = DEFAULT_BIBLE_VERSION
    end

  end
end