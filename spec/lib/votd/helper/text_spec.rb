require 'spec_helper'

include Votd::Helper::Text

describe Votd::Helper::Text do
  describe ".strip_html_tags" do
    it "removes HTML tags from a given string" do
      text = %q[<p>The <span name="foo">quick</span> brown fox.</p><br />]
      strip_html_tags(text).should == "The quick brown fox."
    end
  end

  describe ".clean_verse_start" do
    it "prepends '...' if the first letter is not a capital letter" do
      text = "for God so loved"
      clean_verse_start(text).should == "...for God so loved"
    end
  end

  describe ".clean_verse_end" do
    it "appends '...' if the verse ends without a period" do
      text = "For God so loved"
      clean_verse_end(text).should == "For God so loved..."
    end

    it "appends '...' if the verse ends in a ',' or ';'" do
      ["loved,", "loved;"].each do |text| 
        clean_verse_end(text).should == "loved..."
      end
    end
  end
end
