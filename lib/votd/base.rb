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

    # @example
    #    votd.copyright # "Brought to you by BibleGateway.com. Copyright (C) . All Rights Reserved."
    # @return [String] any copyright information supplied by VotD provider
    attr_reader :copyright

    # The default Bible version to use if none is given and no other default
    # is provided
    DEFAULT_BIBLE_VERSION = "KJV"

    # Initializes the class and retrieves the verse of the day.
    # @return [Base]
    def initialize
      @text      = ""
      @reference = ""
      @copyright = nil
      @date      = Date.today
      @to_html   = nil
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
      @to_html ||= default_html
    end

    # Override the {#to_html} with your own custom HTML. Use a block to specify your
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
    # @return [String] the VotD formatted as custom HTML
    def custom_html
      @to_html = yield(self)
      return @to_html
    end

    protected
    # Gets the VotD. For {Votd::Base} this will return default values and can be
    # used in the event of an exception thrown when getting data from live web
    # services in subclasses of {Votd::Base}
    def get_votd
      @text      = "For God so loved the world, that he gave his only begotten Son, that whosoever believeth in him should not perish, but have everlasting life."
      @reference = "John 3:16"
      @version   = DEFAULT_BIBLE_VERSION
    end

  end
end
