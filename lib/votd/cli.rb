# frozen_string_literal: true

require "thor"
require "votd/helper/command_line"

module Votd
  class CLI < Thor
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
    def version
      puts "votd #{Votd::VERSION}"
    end

    private

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
