require 'spec_helper'

describe "Votd::ESVBible" do
  let(:votd) { Votd::ESVBible.new }
  
  before do
    fake_a_uri(Votd::ESVBible::URI, "esvbible/esvbible.rss")
  end
  
  it "is a type of ESVBible" do
    votd.should be_a(Votd::ESVBible)
  end
  
  describe ".text" do
    it "returns the correct scripture verse" do
      votd.text.should == "For you did not receive the spirit of slavery to fall back into fear, but you have received the Spirit of adoption as sons, by whom we cry, \"Abba! Father!\""
    end
  end
  
  describe ".reference" do
    it "returns the correct scripture reference" do
      votd.reference.should == "Romans 8:15"
    end
  end
  
  describe ".version / .translation" do
    it "returns the correct bible version" do
      votd.version.should == "ESV"
      votd.translation.should == "ESV"
    end
  end
  
  describe ".date" do
    it "returns the correct date" do
      votd.date.should == Date.today
    end
  end
  
  describe ".copyright" do
    it "returns copyright information" do
      votd.copyright.should == "The Holy Bible, English Standard Version copyright 2001 by Crossway Bibles, a publishing ministry of Good News Publishers. Used by permission. All rights reserved."
    end
  end
  
  describe ".to_html" do
    it "returns a HTML version" do
      votd.to_html.should == read_fixture("esvbible/esvbible.html")
    end
  end
  
  describe ".custom_html" do
    it "overrides the default .to_html formatting" do
      votd.custom_html do |votd|
        "<p>#{votd.reference}|#{votd.text}|#{votd.version}</p>"
      end
      votd.to_html.should == read_fixture("esvbible/esvbible_custom.html")
    end
    
    it "generates a VotdError when not used with a block" do
      expect{votd.custom_html}.to raise_error(Votd::VotdError)
    end
  end
  
  describe ".to_text" do
    it "returns a text-formatted version" do
      votd.to_text.should == read_fixture("esvbible/esvbible.txt")
    end
    
    it "is aliased to .to_s" do
      votd.to_s.should == read_fixture("esvbible/esvbible.txt")
    end
  end
  
  describe ".custom_text" do
    it "overrides the default .to_text formatting" do
      text_from_block = votd.custom_text do |votd|
        "#{votd.reference}|#{votd.text}|#{votd.version}"
      end
      desired_output = read_fixture("esvbible/esvbible_custom.txt")
      text_from_block.should == desired_output
      votd.to_text.should    == desired_output
    end
    
    it "generates a VotdError when not used with a block" do
      expect{votd.custom_text}.to raise_error(Votd::VotdError)
    end
  end
  
  context "When an error occurs" do
    before do
      fake_a_broken_uri(Votd::ESVBible::URI)
    end
    
    it "falls back to default VotD values" do
      votd.version.should   == Votd::Base::DEFAULT_BIBLE_VERSION
      votd.reference.should == Votd::Base::DEFAULT_BIBLE_REFERENCE
      votd.text.should      == Votd::Base::DEFAULT_BIBLE_TEXT
    end
  end
  
  context "When the text is not a proper sentence" do
    before do
      fake_a_uri(Votd::ESVBible::URI, "esvbible/esvbible_with_partial.rss")
    end
    
    it "prepends an ellipsis if first letter is not a capital letter" do
      votd.text.should =~ /^\.{3}\w/
    end
    
    it "appends an ellipsis if last character is a letter, a comma or a semicolon" do
      votd.text.should =~ /\w\.{3}$/
    end
  end

end
