require 'spec_helper'
require 'json'

describe "Votd::NETBible" do
  let(:votd) { Votd::NetBible.new }

  it "is a type of NETBible" do
    votd.should be_a(Votd::NetBible)
  end

  describe ".text" do
    it "returns the correct scripture verse" do
      votd.text.should == "For by grace you are saved through faith... it is not from works, so that no one can boast."
    end
  end

  describe ".reference" do
    it "returns the correct scripture reference" do
      votd.reference.should == "Ephesians 2:8-9"
    end
  end

  describe ".version / .translation" do
    it "returns the correct bible version" do
      votd.version.should     == "NETBible"
      votd.translation.should == "NETBible"
    end
  end

  describe ".date" do
    it "returns the correct date" do
      votd.date.should == Date.today
    end
  end

  describe ".copyright" do
    it "returns nil copyright information" do
      votd.copyright.should be_nil
    end
  end

  describe ".to_html" do
    it "returns a HTML version" do
      votd.to_html.should == read_fixture("netbible/netbible.html")
    end
  end

  describe ".custom_html" do
    it "overrides the default .to_html formatting" do
      votd.custom_html do |votd|
        "<p>#{votd.reference}|#{votd.text}|#{votd.version}</p>"
      end
      votd.to_html.should == read_fixture("netbible/netbible_custom.html")
    end
  end

  describe ".to_text" do
    it "returns a text-formatted version" do
      votd.to_text.should == read_fixture("netbible/netbible.txt")
    end

    it "is aliased to .to_s" do
      votd.to_s.should == read_fixture("netbible/netbible.txt")
    end
  end

  describe ".custom_text" do
    it "overrides the default.to_text formatting" do
      text_from_block = votd.custom_text do |votd|
        "#{votd.reference}|#{votd.text}|#{votd.version}"
      end
      desired_output = read_fixture("netbible/netbible_custom.txt")
      text_from_block.should == desired_output
      votd.to_text.should    == desired_output
    end
  end

  context "When an error occurrs" do
    before do
      register_broken_uri(Votd::NetBible::URI)
    end

    it "falls back to default VotD values" do
      votd.version.should   == Votd::Base::DEFAULT_BIBLE_VERSION
      votd.reference.should == Votd::Base::DEFAULT_BIBLE_REFERENCE
      votd.text.should      == Votd::Base::DEFAULT_BIBLE_TEXT
    end
  end


end
