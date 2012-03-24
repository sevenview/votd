require 'spec_helper'

describe "Votd::NETBible" do
  describe "#votd" do
    it "returns a verse of the day" do
      Votd::NETBible.votd.should == "NETBible VOTD goes here"
    end
  end
end