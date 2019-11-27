require 'spec_helper'

describe "Votd::BibleGateway" do
  let(:votd) { Votd::BibleGateway.new }

  before do
    fake_a_uri(Votd::BibleGateway::URI, "bible_gateway/bible_gateway.rss")
  end

  it "is a type of BibleGateway" do
    expect(votd).to be_a(Votd::BibleGateway)
  end

  describe ".text" do
    it "returns the correct scripture verse" do
      expect(votd.text).to eq "If we confess our sins, he is faithful and just and will forgive us our sins and purify us from all unrighteousness."
    end
  end

  describe ".reference" do
    it "returns the correct scripture reference" do
      expect(votd.reference).to eq "1 John 1:9"
    end
  end

  describe ".version / .translation" do
    it "returns the correct bible version" do
      expect(votd.version).to     eq "NIV"
      expect(votd.translation).to eq "NIV"
    end
  end

  describe ".date" do
    it "returns the correct date" do
      expect(votd.date).to eq Date.today
    end
  end

  describe ".copyright" do
    it "returns copyright information" do
      expect(votd.copyright).to eq "Brought to you by BibleGateway.com. Copyright (C) . All Rights Reserved."
    end
  end

  describe ".to_html" do
    it "returns a HTML version" do
      expect(votd.to_html).to eq read_fixture("bible_gateway/bible_gateway.html")
    end
  end

  describe ".custom_html" do
    it "overrides the default .to_html formatting" do
      votd.custom_html do |votd|
        "<p>#{votd.reference}|#{votd.text}|#{votd.version}</p>"
      end
      expect(votd.to_html).to eq read_fixture("bible_gateway/bible_gateway_custom.html")
    end

    it "generates a VotdError when not used with a block" do
      expect{votd.custom_html}.to raise_error(Votd::VotdError)
    end
  end

  describe ".to_text" do
    it "returns a text-formatted version" do
      expect(votd.to_text).to eq read_fixture("bible_gateway/bible_gateway.txt")
    end

    it "is aliased to .to_s" do
      expect(votd.to_s).to eq read_fixture("bible_gateway/bible_gateway.txt")
    end
  end

  describe ".custom_text" do
    it "overrides the default.to_text formatting" do
      text_from_block = votd.custom_text do |votd|
        "#{votd.reference}|#{votd.text}|#{votd.version}"
      end
      desired_output = read_fixture("bible_gateway/bible_gateway_custom.txt")
      expect(text_from_block).to eq desired_output
      expect(votd.to_text).to eq desired_output
    end

    it "generates a VotdError when not used with a block" do
      expect{votd.custom_text}.to raise_error(Votd::VotdError)
    end
  end

  context "When an error occurrs" do
    before do
      fake_a_broken_uri(Votd::BibleGateway::URI)
    end

    it "falls back to default VotD values" do
      expect(votd.version).to eq Votd::Base::DEFAULT_BIBLE_VERSION
      expect(votd.reference).to eq Votd::Base::DEFAULT_BIBLE_REFERENCE
      expect(votd.text).to eq Votd::Base::DEFAULT_BIBLE_TEXT
    end
  end

  context "When the text is not a proper sentence" do
    before do
      fake_a_uri(Votd::BibleGateway::URI, "bible_gateway/bible_gateway_with_partial.rss")
    end

    it "prepends an ellipsis if first letter is not a capital letter" do
      expect(votd.text).to match /^\.{3}\w/
    end

    it "appends an ellipsis if last character is not a period" do
      expect(votd.text).to match /ness\.{3}$/
    end
  end

end
