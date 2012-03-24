require 'spec_helper'
require 'json'

describe "Votd::NETBible" do
  let(:votd) { Votd::NetBible.new }

  it "is a type of NETBible" do
    votd.should be_a(Votd::NetBible)
  end

  it "has a .date" do
    votd.date.should == Date.today
  end

  it "has a .reference" do
    votd.reference.should == "Ephesians 2:8-9"
  end

  it "has a .text" do
    votd.text.should == "For by grace you are saved through faith... it is not from works, so that no one can boast."
  end

  it "has a .version" do
    votd.version.should == "BIBLE.ORG"
  end

  it "returns a HTML version" do
    votd.to_html.should == File.read(fixture("netbible.html"))
  end

end
