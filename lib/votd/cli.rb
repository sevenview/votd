# frozen_string_literal: true

require "thor"
require "votd/helper/command_line"

module Votd
  # Thor-based command-line interface for the votd gem.
  # Provides commands to display the Bible verse of the day
  # from various providers and translations.
  #
  # @example
  #   # From the shell:
  #   votd verse
  #   votd verse --provider netbible
  #   votd verse --provider biblegateway --translation kjv --format json
  #   votd version
  class CLI < Thor
    # @return [Boolean] true so Thor exits with status 1 on errors
    def self.exit_on_failure?
      true
    end

    desc "verse", "Display today's Bible verse of the day"
    option :provider, type: :string, default: "biblegateway", aliases: "-p",
      desc: "VotD provider (biblegateway, netbible, ourmanna)"
    option :translation, type: :string, default: "niv",
      desc: "Bible translation for BibleGateway (e.g. kjv, esv, nlt)"
    option :format, type: :string, default: "text", aliases: "-f",
      desc: "Output format (text, html, json)"
    option :help, type: :boolean, aliases: "-h", hide: true
    # Fetches and displays the verse of the day.
    # @return [void]
    def verse
      return invoke(:help, ["verse"]) if options[:help]
      votd = build_votd(options[:provider], options[:translation])
      output(votd, options[:format])
    rescue InvalidBibleVersion
      warn "Error: Unknown translation '#{options[:translation]}'"
      warn "Valid translations: #{BibleGateway::BIBLE_VERSIONS.keys.join(", ")}"
      exit 1
    rescue FetchError => e
      warn "Error: #{e.message}"
      exit 1
    end

    desc "version", "Show votd gem version"
    # Prints the votd gem version.
    # @return [void]
    def version
      puts "votd #{Votd::VERSION}"
    end

    private

    # Instantiates the appropriate VotD provider.
    # @param [String] provider the provider name ("biblegateway", "netbible", or "ourmanna")
    # @param [String] translation the Bible translation key (only used for BibleGateway)
    # @return [Base] a VotD provider instance
    def build_votd(provider, translation)
      case provider
      when "biblegateway" then BibleGateway.new(translation.to_sym)
      when "netbible" then NetBible.new
      when "ourmanna" then OurManna.new
      else
        warn "Error: Unknown provider '#{provider}'"
        warn "Valid providers: biblegateway, netbible, ourmanna"
        exit 1
      end
    end

    # Renders the VotD in the requested format.
    # @param [Base] votd the verse of the day instance
    # @param [String] format output format ("text", "html", or "json")
    # @return [void]
    def output(votd, format)
      case format
      when "text" then output_text(votd)
      when "html" then puts votd.to_html
      when "json" then output_json(votd)
      else
        warn "Error: Unknown format '#{format}'"
        warn "Valid formats: text, html, json"
        exit 1
      end
    end

    # Renders the VotD as formatted plain text with a banner.
    # @param [Base] votd the verse of the day instance
    # @return [void]
    def output_text(votd)
      line_width = 40
      Helper::CommandLine.banner("VERSE OF THE DAY for #{votd.date}", line_width)
      puts "\n"
      puts Helper::CommandLine.word_wrap(votd.to_text, line_width)

      if votd.copyright
        puts "\n"
        Helper::CommandLine.banner(Helper::CommandLine.word_wrap(votd.copyright, line_width), line_width)
      end
    end

    # Renders the VotD as pretty-printed JSON.
    # @param [Base] votd the verse of the day instance
    # @return [void]
    def output_json(votd)
      puts JSON.pretty_generate({
        reference: votd.reference,
        text: votd.text,
        version: votd.version,
        version_name: votd.version_name,
        date: votd.date.to_s,
        link: votd.link,
        copyright: votd.copyright
      })
    end
  end
end
