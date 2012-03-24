require 'spec_helper'

describe "Votd::ESV" do
  describe "#votd" do
    it "returns a verse of the day" do
      Votd::ESV.votd.should == "ESV VOTD goes here"
    end
  end
end