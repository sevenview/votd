require "spec_helper"

describe "Votd::NETBible" do
  let(:votd) { Votd::NetBible.new }

  context "with the default fixture" do
    before do
      fake_a_uri(Votd::NetBible::ENDPOINT_URL, "netbible/netbible.json")
    end

    it "is a type of NETBible" do
      expect(votd).to be_a(Votd::NetBible)
    end

    describe ".text" do
      it "returns the correct scripture verse" do
        expect(votd.text).to eq "For by grace you are saved through faith... it is not from works, so that no one can boast."
      end
    end

    describe ".reference" do
      it "returns the correct scripture reference" do
        expect(votd.reference).to eq "Ephesians 2:8-9"
      end
    end

    describe ".version / .translation" do
      it "returns the correct bible version" do
        expect(votd.version).to eq "NETBible"
        expect(votd.translation).to eq "NETBible"
      end
    end

    describe ".version_name / .translation_name" do
      it "returns the correct bible version" do
        expect(votd.version_name).to eq "NET Bible"
        expect(votd.translation_name).to eq "NET Bible"
      end
    end

    describe ".date" do
      it "returns the correct date" do
        expect(votd.date).to eq Date.today
      end
    end

    describe ".copyright" do
      it "returns nil copyright information" do
        expect(votd.copyright).to be_nil
      end
    end

    describe ".link" do
      it "returns the link" do
        expect(votd.link).to eq "https://netbible.org/bible/Ephesians+2:8"
      end
    end

    describe ".to_html" do
      it "returns a HTML version" do
        expect(votd.to_html).to eq read_fixture("netbible/netbible.html")
      end
    end

    describe ".custom_html" do
      it "overrides the default .to_html formatting" do
        votd.custom_html do |votd|
          "<p>#{votd.reference}|#{votd.text}|#{votd.version}</p>"
        end
        expect(votd.to_html).to eq read_fixture("netbible/netbible_custom.html")
      end

      it "generates a VotdError when not used with a block" do
        expect { votd.custom_html }.to raise_error(Votd::VotdError)
      end
    end

    describe ".to_text" do
      it "returns a text-formatted version" do
        expect(votd.to_text).to eq read_fixture("netbible/netbible.txt")
      end

      it "is aliased to .to_s" do
        expect(votd.to_s).to eq read_fixture("netbible/netbible.txt")
      end
    end

    describe ".custom_text" do
      it "overrides the default.to_text formatting" do
        text_from_block = votd.custom_text do |votd|
          "#{votd.reference}|#{votd.text}|#{votd.version}"
        end
        desired_output = read_fixture("netbible/netbible_custom.txt")
        expect(text_from_block).to eq desired_output
        expect(votd.to_text).to eq desired_output
      end

      it "generates a VotdError when not used with a block" do
        expect { votd.custom_text }.to raise_error(Votd::VotdError)
      end
    end
  end

  context "when the response contains HTML tags" do
    before do
      fake_a_uri(Votd::NetBible::ENDPOINT_URL, "netbible/netbible_with_html.json")
    end

    it "strips HTML tags from text" do
      expect(votd.text).to_not match(/<\/?[^>]*>/)
    end
  end

  context "When an error occurs" do
    context "with a malformed response body" do
      before { fake_a_broken_uri(Votd::NetBible::ENDPOINT_URL) }
      include_examples "falls back to defaults"
    end

    context "with a network timeout" do
      before { stub_request(:get, Votd::NetBible::ENDPOINT_URL).to_timeout }
      include_examples "falls back to defaults"
    end

    context "with a connection failure" do
      before { stub_request(:get, Votd::NetBible::ENDPOINT_URL).to_raise(SocketError) }
      include_examples "falls back to defaults"
    end

    context "with an HTTP 500 response" do
      before { stub_request(:get, Votd::NetBible::ENDPOINT_URL).to_return(status: 500, body: "Internal Server Error") }
      include_examples "falls back to defaults"
    end

    context "with an empty response body" do
      before { stub_request(:get, Votd::NetBible::ENDPOINT_URL).to_return(body: "") }
      include_examples "falls back to defaults"
    end
  end

  context "When the text is not a proper sentence" do
    before do
      fake_a_uri(Votd::NetBible::ENDPOINT_URL, "netbible/netbible_with_partial.json")
    end

    it "prepends an ellipsis if first letter is not a capital letter" do
      expect(votd.text).to match(/^\.{3}\w/)
    end

    it "appends an ellipsis if last character is not a period" do
      expect(votd.text).to match(/\w\.{1,3}$/)
    end
  end
end
