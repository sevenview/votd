module Votd
  # This is the base class that all Votd lookup modules inherit from.
  # It provides default values for the Votd in the event of lookup failure.
  # Child classes should override the get_votd method to implement their
  # specific lookup function.
  class Base
    # @return [string] the default bible verse
    attr_reader :text
    # @return [string] the default scripture reference
    attr_reader :reference
    # @return [string] the default date of the VotD
    attr_reader :date
    # @return [string] the default bible version
    attr_reader :version

    # The default Bible version to use if none is given and no other default
    # is provided
    DEFAULT_BIBLE_VERSION = "KJV"

    # Initializes the class
    def initialize
      @text      = ""
      @reference = ""
      @date      = Date.today
      get_votd
    end

    # @macro votd.to_html
    def to_html
      html =  "<p class=\"votd-text\">#{@text}</p>\n"
      html << "<p>\n"
      html << "<span class=\"votd-reference\"><strong>#{@reference}</strong></span>\n"
      html << "<span class=\"votd-version\"><em>(#{@version})</em></span>\n"
      html << "</p>\n"
      html
    end

    private
    # Gets the VotD. For base class this will return default values and can be
    # used in the event of an exception thrown in the subclassed modules.
    def get_votd
      @text      = "For God so loved the world, that he gave his only begotten Son, that whosoever believeth in him should not perish, but have everlasting life."
      @reference = "John 3:16"
      @version   = DEFAULT_BIBLE_VERSION
    end

  end
end