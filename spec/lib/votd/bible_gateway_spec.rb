require 'spec_helper'

describe "Votd::BibleGateway" do
  let(:votd) { Votd::BibleGateway.new }

  it "is a type of BibleGateway" do
    votd.should be_a(Votd::BibleGateway)
  end

  describe ".text" do
    it "returns the correct scripture verse" do
      votd.text.should == "If we confess our sins, he is faithful and just and will forgive us our sins and purify us from all unrighteousness."
    end
  end

  describe ".reference" do
    it "returns the correct scripture reference" do
      votd.reference.should == "1 John 1:9"
    end
  end

  describe ".version" do
    it "returns the correct bible version" do
      votd.version.should == "NIV"
    end
  end

  describe ".date" do
    it "returns the correct date" do
      votd.date.should == Date.today
    end
  end

  describe ".copyright" do
    it "returns copyright information" do
      votd.copyright.should == "Brought to you by BibleGateway.com. Copyright (C) . All Rights Reserved."
    end
  end

  describe ".to_html" do
    it "returns a HTML version" do
      votd.to_html.should == File.read(fixture("bible_gateway.html"))
    end
  end

  describe ".custom_html" do
    it "overrides the default .to_html formatting" do
      votd.custom_html do |votd|
        "<p>#{votd.reference}|#{votd.text}|#{votd.version}</p>"
      end
      votd.to_html.should == "<p>1 John 1:9|If we confess our sins, he is faithful and just and will forgive us our sins and purify us from all unrighteousness.|NIV</p>"
    end
  end

end
