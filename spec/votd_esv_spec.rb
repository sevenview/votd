require 'spec_helper'
require 'json'

describe "Votd::ESV" do
  describe "#votd" do
    let(:esv) { Votd::ESV.new }

    before do
      @parsed_json = JSON.parse(esv.votd)
    end

    it "returns a verse of the day" do
      esv.votd.should == File.read("spec/fixtures/votd.json")
    end

    it "returns valid JSON" do
      @parsed_json.should be_a(Hash)
    end

    context "Parsed JSON data:" do
      it "contains a date field" do
        @parsed_json["date"].should == "2012-03-24"
      end

      it "contains a reference field" do
        @parsed_json["reference"].should == "John 3:16"
      end

      it "contains a text field" do
        @parsed_json["text"].should == "For God so loved the world..."
      end

      it "contains a version field" do
        @parsed_json["version"].should == "ESV"
      end
    end
  end
end