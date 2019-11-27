require 'spec_helper'

include Votd::Helper::Text

describe Votd::Helper::Text do
  describe ".strip_html_tags" do
    it "removes HTML tags from a given string" do
      text = %q[<p>The <span name="foo">quick</span> brown fox.</p><br />]
      expect(strip_html_tags(text)).to eq "The quick brown fox."
    end
  end

  describe ".clean_verse_start" do
    it "prepends '...' if the first letter is not a capital letter" do
      text = "for God so loved"
      expect(clean_verse_start(text)).to eq "...for God so loved"
    end
  end

  describe ".clean_verse_end" do
    it "appends '...' if the verse ends without a period" do
      text = "For God so loved"
      expect(clean_verse_end(text)).to eq "For God so loved..."
    end

    it "appends '...' if the verse ends in a ',' or ';'" do
      ["loved,", "loved;"].each do |text|
        expect(clean_verse_end(text)).to eq "loved..."
      end
    end
  end
end
