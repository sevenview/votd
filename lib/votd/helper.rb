module Votd
  # This module provides various helper methods used throughout the
  # codebase.
  module Helper
    module CommandLine
      extend self
      # Generates a text banner suitable for displaying from a command-line
      # utility, for example. Use with a block.
      # @example
      #   banner(20) { "My Banner" }
      #
      #   ->
      #   ====================
      #   My Banner
      #   ====================
      # @param [Integer] line_width number of columns for width
      # @return [String] the banner text
      def banner(line_width=40)
        banner_text = "=" * line_width
        banner_text << "\n"
        banner_text << yield.center(line_width)
        banner_text << "\n"
        banner_text << "=" * line_width
        banner_text
      end

      # Word-wraps text to the specified column width.
      # @param [String] text the text to be wrapped
      # @param [Integer] line_width column width
      # @return [String] wrapped text
      def word_wrap(text, line_width=40)
        text.split("\n").collect do |line|
          line.length > line_width ? line.gsub(/(.{1,#{line_width}})(\s+|$)/, "\\1\n").strip : line
        end * "\n"
      end
    end

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
