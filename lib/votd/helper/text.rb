module Votd
  module Helper
    # This module contains helper methods that support the
    # VotD text parsing
    module Text
      extend self
      # Removes HTML tags from the given text
      # @param [String] text the text you want to strip HTML tags from
      # @return [String]
      def strip_html_tags(text)
        text.gsub(/<\/?[^>]*>/, '')
      end
    end
  end
end
