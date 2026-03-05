require "spec_helper"
require "logger"

describe "Votd::Base" do
  let(:votd) { Votd::Base.new }

  describe ".text" do
    it "returns the default scripture verse" do
      expect(votd.text).to eq "For God so loved the world, that he gave his only begotten Son, that whosoever believeth in him should not perish, but have everlasting life."
    end
  end

  describe ".reference" do
    it "returns the default scripture reference" do
      expect(votd.reference).to eq "John 3:16"
    end
  end

  describe ".version / .translation" do
    it "returns the default bible version" do
      expect(votd.translation).to eq "KJV"
      expect(votd.version).to eq "KJV"
    end
  end

  describe ".version_name / .translation_name" do
    it "returns the default bible version" do
      expect(votd.translation_name).to eq "King James Version"
      expect(votd.version_name).to eq "King James Version"
    end
  end

  describe ".link" do
    it "returns the default link" do
      expect(votd.link).to eq "https://www.biblegateway.com/passage/?search=John+3%3A16&version=KJV"
    end
  end

  describe ".date" do
    it "returns the default date" do
      expect(votd.date).to eq Date.today
    end
  end

  describe ".copyright" do
    it "returns nil copyright information" do
      expect(votd.copyright).to be_nil
    end
  end

  describe ".to_html" do
    it "returns a HTML version" do
      expect(votd.to_html).to eq read_fixture("base/base.html")
    end
  end

  describe ".custom_html" do
    it "returns custom HTML and overrides the default .to_html formatting" do
      html_from_block = votd.custom_html do |votd|
        "<p>#{votd.reference}|#{votd.text}|#{votd.version}</p>"
      end
      desired_output = read_fixture("base/base_custom.html")
      expect(html_from_block).to eq desired_output
      expect(votd.to_html).to eq desired_output
    end

    it "generates a VotdError when not used with a block" do
      expect { votd.custom_html }.to raise_error(Votd::VotdError)
    end
  end

  describe ".to_text" do
    it "returns a text-formatted version" do
      expect(votd.to_text).to eq read_fixture("base/base.txt")
    end

    it "is aliased to .to_s" do
      expect(votd.to_s).to eq read_fixture("base/base.txt")
    end
  end

  describe ".custom_text" do
    it "overrides the default.to_text formatting" do
      text_from_block = votd.custom_text do |votd|
        "#{votd.reference}|#{votd.text}|#{votd.version}"
      end
      desired_output = read_fixture("base/base_custom.txt")
      expect(text_from_block).to eq desired_output
      expect(votd.to_text).to eq desired_output
    end

    it "generates a VotdError when not used with a block" do
      expect { votd.custom_text }.to raise_error(Votd::VotdError)
    end
  end

  describe "Votd.logger" do
    it "logs errors when a provider fails" do
      logger = instance_double(Logger)
      Votd.logger = logger
      expect(logger).to receive(:error).with(/BibleGateway.*SocketError/)

      stub_request(:get, /biblegateway/).to_raise(SocketError)
      expect { Votd::BibleGateway.new }.to raise_error(Votd::FetchError)
    end

    it "does not raise when no logger is configured" do
      stub_request(:get, /biblegateway/).to_raise(SocketError)
      expect { Votd::BibleGateway.new }.to raise_error(Votd::FetchError)
    end
  end

  describe "Votd.on_error" do
    it "invokes the callback with provider class and error" do
      callback_args = nil
      Votd.on_error do |provider_class, error|
        callback_args = [provider_class, error]
      end

      stub_request(:get, /biblegateway/).to_raise(SocketError)
      expect { Votd::BibleGateway.new }.to raise_error(Votd::FetchError)

      expect(callback_args).not_to be_nil
      expect(callback_args[0]).to eq Votd::BibleGateway
      expect(callback_args[1]).to be_a(Votd::FetchError)
    end
  end

  describe "Votd.reset_configuration" do
    it "clears logger and on_error callback" do
      Votd.logger = Logger.new($stderr)
      Votd.on_error { |_provider, _error| }

      Votd.reset_configuration

      expect(Votd.logger).to be_nil
      expect(Votd.on_error_callback).to be_nil
    end
  end

  describe "Votd::FetchError" do
    it "is a subclass of VotdError" do
      expect(Votd::FetchError.superclass).to eq Votd::VotdError
    end

    it "preserves the original exception as #cause" do
      stub_request(:get, /biblegateway/).to_raise(SocketError.new("connection refused"))

      begin
        Votd::BibleGateway.new
      rescue Votd::FetchError => e
        expect(e.cause).to be_a(SocketError)
        expect(e.cause.message).to eq "connection refused"
        expect(e.message).to include("Failed to fetch verse from BibleGateway")
      end
    end
  end
end
