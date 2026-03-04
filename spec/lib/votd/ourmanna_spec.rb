require "spec_helper"

describe "Votd::OurManna" do
  let(:votd) { Votd::OurManna.new }

  context "with the default fixture" do
    before do
      fake_a_uri(Votd::OurManna::ENDPOINT_URL, "ourmanna/ourmanna.json")
    end

    it "is a type of OurManna" do
      expect(votd).to be_a(Votd::OurManna)
    end

    describe ".text" do
      it "returns the correct scripture verse" do
        expect(votd.text).to eq "The name of the Lord is a strong tower; the righteous run to it and are safe."
      end
    end

    describe ".reference" do
      it "returns the correct scripture reference" do
        expect(votd.reference).to eq "Proverbs 18:10"
      end
    end

    describe ".version / .translation" do
      it "returns the correct bible version" do
        expect(votd.version).to eq "NIV"
        expect(votd.translation).to eq "NIV"
      end
    end

    describe ".version_name / .translation_name" do
      it "returns the correct bible version name" do
        expect(votd.version_name).to eq "New International Version"
        expect(votd.translation_name).to eq "New International Version"
      end
    end

    describe ".date" do
      it "returns the correct date" do
        expect(votd.date).to eq Date.today
      end
    end

    describe ".copyright" do
      it "returns the copyright information" do
        expect(votd.copyright).to eq "Powered by OurManna.com"
      end
    end

    describe ".link" do
      it "returns the link" do
        expect(votd.link).to eq "http://www.ourmanna.com/"
      end
    end

    describe ".to_html" do
      it "returns a HTML version" do
        expect(votd.to_html).to eq read_fixture("ourmanna/ourmanna.html")
      end
    end

    describe ".custom_html" do
      it "overrides the default .to_html formatting" do
        votd.custom_html do |votd|
          "<p>#{votd.reference}|#{votd.text}|#{votd.version}</p>"
        end
        expect(votd.to_html).to eq read_fixture("ourmanna/ourmanna_custom.html")
      end

      it "generates a VotdError when not used with a block" do
        expect { votd.custom_html }.to raise_error(Votd::VotdError)
      end
    end

    describe ".to_text" do
      it "returns a text-formatted version" do
        expect(votd.to_text).to eq read_fixture("ourmanna/ourmanna.txt")
      end

      it "is aliased to .to_s" do
        expect(votd.to_s).to eq read_fixture("ourmanna/ourmanna.txt")
      end
    end

    describe ".custom_text" do
      it "overrides the default .to_text formatting" do
        text_from_block = votd.custom_text do |votd|
          "#{votd.reference}|#{votd.text}|#{votd.version}"
        end
        desired_output = read_fixture("ourmanna/ourmanna_custom.txt")
        expect(text_from_block).to eq desired_output
        expect(votd.to_text).to eq desired_output
      end

      it "generates a VotdError when not used with a block" do
        expect { votd.custom_text }.to raise_error(Votd::VotdError)
      end
    end
  end

  context "When an error occurs" do
    before do
      fake_a_broken_uri(Votd::OurManna::ENDPOINT_URL)
    end

    it "falls back to default VotD values" do
      expect(votd.version).to eq Votd::Base::DEFAULT_BIBLE_VERSION
      expect(votd.reference).to eq Votd::Base::DEFAULT_BIBLE_REFERENCE
      expect(votd.text).to eq Votd::Base::DEFAULT_BIBLE_TEXT
    end
  end

  context "When the text is not a proper sentence" do
    before do
      fake_a_uri(Votd::OurManna::ENDPOINT_URL, "ourmanna/ourmanna_with_partial.json")
    end

    it "prepends an ellipsis if first letter is not a capital letter" do
      expect(votd.text).to match(/^\.{3}\w/)
    end

    it "appends an ellipsis if last character is not a period" do
      expect(votd.text).to match(/\w\.{3}$/)
    end
  end
end
