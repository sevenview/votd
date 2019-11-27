require 'spec_helper'

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
    it 'returns the default link' do
      expect(votd.link).to eq 'https://www.biblegateway.com/passage/?search=John+3%3A16&version=KJV'
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
      expect{votd.custom_html}.to raise_error(Votd::VotdError)
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
      expect{votd.custom_text}.to raise_error(Votd::VotdError)
    end
  end

end
