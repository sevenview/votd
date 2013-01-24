module Votd
  module Helper
    # This module contains helper methods that support the
    # VotD text parsing.
    module Text
      extend self
      # Removes HTML tags from the given text
      # @param [String] text the text you want to strip HTML tags from
      # @return [String]
      def strip_html_tags(text)
        text.gsub(/<\/?[^>]*>/, '')
      end
      
      # Prepends '...' if first letter is not a capital letter
      # @param [String] text the text to process
      # @return [String]
      def clean_verse_start(text)
        text.sub(/^([a-z])/, '...\1')
      end

      # Appends '...' if verse ends abruptly
      # @param [String] text the text to process
      # @return [String]
      def clean_verse_end(text)
        case text
        when /[a-zA-Z]$/         # no ending "."
          text << '...'
        when /[,;]$/
          text.sub!(/[,;]$/, '...') # ends with "," or ";"
        else
          text
        end
        text
      end

    end
  end
end
