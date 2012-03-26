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

  describe ".version" do
    it "returns the default bible version" do
      votd.version.should == "KJV"
    end
  end

  describe ".date" do
    it "returns the default date" do
      votd.date.should == Date.today
    end
  end
end