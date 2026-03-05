# frozen_string_literal: true

module Votd
  # Retrieves a Verse of the Day from https://ourmanna.com using the NIV
  # translation.
  #
  # @example
  #   votd = Votd::OurManna.new
  #   votd.text       # => "For God so loved the world..."
  #   votd.reference  # => "John 3:16"
  #   votd.version    # => "NIV"
  class OurManna < Votd::Base
    # The name of the Bible Translation that this module generates
    BIBLE_VERSION = "NIV"
    # The full name of the Bible translation
    BIBLE_VERSION_NAME = "New International Version"

    # The URL of the API gateway
    ENDPOINT_URL = "https://beta.ourmanna.com/api/v1/get?format=json&order=daily"

    private

    # Fetches the verse of the day in JSON format from ourmanna.com.
    # Parses the response and extracts reference, text, link, and copyright.
    # @raise [FetchError] if the HTTP request or JSON parsing fails
    # @return [void]
    def get_votd
      data = JSON.parse(HTTParty.get(ENDPOINT_URL).body)
      details = data["verse"]["details"]

      @reference = details["reference"]
      @version = BIBLE_VERSION
      @version_name = BIBLE_VERSION_NAME
      @link = details["verseurl"]

      text = Helper::Text.strip_html_tags(details["text"])
      text = Helper::Text.clean_verse_start(text)
      @text = Helper::Text.clean_verse_end(text)

      @copyright = data["verse"]["notice"]
    rescue => e
      report_and_raise(e, "Failed to fetch verse from OurManna")
    end
  end
end
