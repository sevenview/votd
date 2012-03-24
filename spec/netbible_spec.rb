require 'spec_helper'
require 'json'

describe "Votd::NETBible" do
  describe "#votd" do
    let(:votd) { Votd::NETBible.votd }

    before do
      @parsed_json = JSON.parse(votd)
    end

    it "returns valid JSON" do
      @parsed_json.should be_a(Hash)
    end

    context "Parsed JSON data:" do
      it "contains a date field" do
        @parsed_json["date"].should == Date.today.to_s
      end

      it "contains a reference field" do
        @parsed_json["reference"].should == "Ephesians 2:8-9"
      end

      it "contains a text field" do
        @parsed_json["text"].should == "For by grace you are saved through faith... it is not from works, so that no one can boast."
      end

      it "contains a version field" do
        @parsed_json["version"].should == "BIBLE.ORG"
      end
    end
  end

end
