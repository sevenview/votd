require 'spec_helper'

describe "Votd::BibleGateway" do
  let(:votd) { Votd::BibleGateway.new }

  it "is a type of BibleGateway" do
    votd.should be_a(Votd::BibleGateway)
  end

  it "has a .date" do
    votd.date.should == Date.today
  end

  it "has a .reference" do
    votd.reference.should == "1 John 1:9"
  end

  it "has a .text" do
    votd.text.should == "&ldquo;If we confess our sins, he is faithful and just and will forgive us our sins and purify us from all unrighteousness.&rdquo;<br/><br/> Brought to you by <a href=\"http://www.biblegateway.com\">BibleGateway.com</a>. Copyright (C) . All Rights Reserved."
  end

  it "has a .version" do
    votd.version.should == "NIV"
  end

  it "returns a HTML version" do
    votd.to_html.should == File.read(fixture("bible_gateway.html"))
  end
end