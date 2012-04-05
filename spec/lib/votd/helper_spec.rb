require 'spec_helper'

include Votd::Helper

describe Votd::Helper::CommandLine do
  describe "#banner" do
    it "prints a banner wrapped at the correct location" do
      CommandLine.banner(6){ "foo" }.should == "======\n foo  \n======"
    end
  end

  describe "#word_wrap" do
    it "wraps text at the specified column" do
      text = "The quick brown fox jumps over the lazy dog."
      CommandLine.word_wrap(text, 20).should == "The quick brown fox\njumps over the lazy\ndog."
    end
  end
end
