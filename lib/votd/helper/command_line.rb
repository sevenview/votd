module Votd
  module Helper
    # This module contains helper methods that support the
    # command-line application
    module CommandLine
      extend self
      # Generates a text banner suitable for displaying from a command-line
      # utility.
      # @example
      #   banner("My Banner", 20)
      #
      #   ->
      #   ====================
      #        My Banner
      #   ====================
      # @param [Integer] line_width number of columns for width
      # @param [String] text text to print inside the banner
      # @return [nil]
      def banner(text, line_width=40)
        banner_text = "=" * line_width
        banner_text << "\n"
        banner_text << text.center(line_width)
        banner_text << "\n"
        banner_text <<  "=" * line_width
        puts banner_text
        nil
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
  end
end
