require 'spec_helper'
require 'fileutils'

describe "Votd::ESV" do
  describe "#votd" do
    it "returns a verse of the day" do
      Votd::ESV.votd.should == File.read("spec/fixtures/votd.json")
    end
  end
end