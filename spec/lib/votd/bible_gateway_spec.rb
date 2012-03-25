require 'spec_helper'

describe "BibleGateway" do
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
  #
  #it "has a .text" do
  #  votd.text.should == "For by grace you are saved through faith... it is not from works, so that no one can boast."
  #end
  #
  #it "has a .version" do
  #  votd.version.should == "NETBible"
  #end
  #
  #it "returns a HTML version" do
  #  votd.to_html.should == File.read(fixture("netbible.html"))
  #end
end