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

  describe ".version" do
    it "returns the correct bible version" do
      votd.version.should == "NETBible"
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
      votd.to_html.should == File.read(fixture("netbible.html"))
    end
  end

  describe ".custom_html" do
    it "overrides the default .to_html formatting" do
      votd.custom_html do |votd|
        "<p>#{votd.reference}|#{votd.text}|#{votd.version}</p>"
      end
      votd.to_html.should == "<p>Ephesians 2:8-9|For by grace you are saved through faith... it is not from works, so that no one can boast.|NETBible</p>"
    end
  end

end
