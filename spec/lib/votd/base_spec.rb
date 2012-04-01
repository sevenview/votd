require 'spec_helper'

describe "Votd::Base" do
  let(:votd) { Votd::Base.new }

  describe ".text" do
    it "returns the default scripture verse" do
      votd.text.should == "For God so loved the world, that he gave his only begotten Son, that whosoever believeth in him should not perish, but have everlasting life."
    end
  end

  describe ".reference" do
    it "returns the default scripture reference" do
      votd.reference.should == "John 3:16"
    end
  end

  describe ".version / .translation" do
    it "returns the default bible version" do
      votd.translation.should == "KJV"
      votd.version.should     == "KJV"
    end
  end

  describe ".date" do
    it "returns the default date" do
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
      votd.to_html.should == read_fixture("base/base.html")
    end
  end

  describe ".custom_html" do
    it "returns custom HTML and overrides the default .to_html formatting" do
      html_from_block = votd.custom_html do |votd|
        "<p>#{votd.reference}|#{votd.text}|#{votd.version}</p>"
      end
      desired_output = read_fixture("base/base_custom.html")
      html_from_block.should == desired_output
      votd.to_html.should    == desired_output
    end

    it "generates a VotdError on error" do
      expect{votd.custom_html}.to raise_error(Votd::VotdError)
    end
  end

  describe ".to_text" do
    it "returns a text-formatted version" do
      votd.to_text.should == read_fixture("base/base.txt")
    end

    it "is aliased to .to_s" do
      votd.to_s.should == read_fixture("base/base.txt")
    end
  end

  describe ".custom_text" do
    it "overrides the default.to_text formatting" do
      text_from_block = votd.custom_text do |votd|
        "#{votd.reference}|#{votd.text}|#{votd.version}"
      end
      desired_output = read_fixture("base/base_custom.txt")
      text_from_block.should == desired_output
      votd.to_text.should    == desired_output
    end
  end

end
