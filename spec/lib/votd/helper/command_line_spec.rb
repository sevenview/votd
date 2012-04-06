require 'spec_helper'
require 'votd/helper/command_line'

include Votd::Helper::CommandLine

describe Votd::Helper::CommandLine do
  describe "#banner" do
    it "prints a banner wrapped at the correct location" do
      $stdout.should_receive(:puts).with("======\n foo  \n======")
      banner("foo", 6)
    end
  end

  describe "#word_wrap" do
    it "wraps text at the specified column" do
      text = "The quick brown fox jumps over the lazy dog."
      word_wrap(text, 20).should == "The quick brown fox\njumps over the lazy\ndog."
    end
  end
end
