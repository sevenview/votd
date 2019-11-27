require 'votd/helper/text'

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
    #   votd.reference  # "Ephesians 2:8-9"
    #
    # @return [String] the scripture reference.
    attr_reader :reference

    # @example
    #   votd.date  # "2012-03-24"
    #
    # @return [String] the date the Verse was retrieved
    attr_reader :date

    # @example
    #   votd.version  # "NIV"
    # @return [String] the bible translation acronym used for this VotD
    attr_reader :version
    alias_method :translation, :version

    # @example
    #   votd.version_name  # "New International Version"
    # @return [String] the bible translation name used for this VotD
    attr_reader :version_name
    alias_method :translation_name, :version_name

    # @example
    #   votd.copyright # "Brought to you by BibleGateway.com. Copyright (C) . All Rights Reserved."
    # @return [String] any copyright information supplied by VotD provider
    attr_reader :copyright

    # @example
    #   votd.link  # "https://www.biblegateway.com/passage/?search=Colossians+3%3A16&version=NIV"
    #
    # @return [String] A URL link to the verse on the corresponding Bible service.
    attr_reader :link

    # The default Bible text to use. This is used in case of an error
    # retrieving the VotD from a remote server
    DEFAULT_BIBLE_TEXT = "For God so loved the world, that he gave his only begotten Son, that whosoever believeth in him should not perish, but have everlasting life."

    # The default Bible reference to use. This is used in case of an error
    # retrieving the VotD from a remote server
    DEFAULT_BIBLE_REFERENCE = "John 3:16"

    # The default Bible version to use if none is given and no other default
    # is provided
    DEFAULT_BIBLE_VERSION = "KJV"

    # The default Bible version name to use if none is given and no other default
    # is provided
    DEFAULT_BIBLE_VERSION_NAME = "King James Version"

    DEFAULT_LINK = "https://www.biblegateway.com/passage/?search=John+3%3A16&version=KJV"

    # Initializes the class and retrieves the verse of the day.
    # @return [Base]
    def initialize
      @text        = ""
      @reference   = ""
      @copyright   = nil
      @date        = Date.today
      @custom_html = nil
      @custom_text = nil
      @link        = nil
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
    # sufficient, you can build the HTML by hand using the individual data,
    # or use the {#custom_html} method to override the HTML format.
    #
    # @return [String] the VotD formatted as HTML
    def to_html
      default_html =  "<p class=\"votd-text\">#{@text}</p>\n"
      default_html << "<p>\n"
      default_html << "<span class=\"votd-reference\"><strong>#{@reference}</strong></span>\n"
      default_html << "<span class=\"votd-version\"><em>(#{@version})</em></span>\n"
      default_html << "</p>\n"
      @custom_html ||= default_html
    end

    # Overrides the {#to_html} method with your own custom HTML. Use a block to specify your
    # custom HTML.
    # @example
    #   votd.custom_html do |votd|
    #     "<p>#{votd.reference} - #{votd.text} (#{votd.version})</p>"
    #   end
    #
    #   # outputs:
    #   # <p>John 3:16 - For God so loved... (KJV)</p>
    #
    # This returns the custom formatted HTML, or you can call the {#to_html} method
    # when ready and your custom HTML will be output.
    #
    # @yield [votd] the VotD itself
    # @yieldparam [Base] votd the VotD itself
    # @yieldreturn [String] the VotD formatted as custom HTML
    # @raise {VotdError} when called without block format
    def custom_html
      if block_given?
        @custom_html = yield(self)
      else
        raise Votd::VotdError, "You must use a block with this method"
      end
    end

    # Returns the Verse of the Day formatted as plain text. e.g.
    #   For God so loved the world... -- John 3:16 (KJV)
    #
    # You can override this formatting with the {#custom_text} method.
    # @return [String] the VotD formatted as plain text
    def to_text
      @custom_text ||= "#{@text} -- #{@reference} (#{@version})"
    end
    alias_method :to_s, :to_text

    # Overrides the {#to_text} with your own custom text. Use a block to specify
    # your custom text.
    # @example
    #   votd.custom_text do |votd|
    #     "#{votd.reference}|#{votd.text}|#{votd.version}"
    #   end
    #
    #   # outputs:
    #   John 3:16|For God so loved...|(KJV)
    #
    # This returns the custom formatted text, or you can call the {#to_text} method
    # when ready, and your custom text will be output.
    #
    # @yield [votd] the VotD itself
    # @yieldparam [Base] votd the VotD itself
    # @yieldreturn [String] the VotD formatted as custom text
    # @raise {VotdError} when called without block format
    def custom_text
      if block_given?
        @custom_text = yield(self)
      else
        raise Votd::VotdError, "You must use a block with this method"
      end
    end

    protected
    # Gets the VotD. For {Votd::Base} this will return default values and can be
    # used in the event of an exception thrown when getting data from live web
    # services in subclasses of {Votd::Base}
    def get_votd
      set_defaults
    end

    def set_defaults
      @text         = DEFAULT_BIBLE_TEXT
      @reference    = DEFAULT_BIBLE_REFERENCE
      @version      = DEFAULT_BIBLE_VERSION
      @version_name = DEFAULT_BIBLE_VERSION_NAME
      @link         = DEFAULT_LINK
      @copyright    = nil
    end

  end
end
