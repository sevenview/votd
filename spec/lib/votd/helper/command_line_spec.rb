# frozen_string_literal: true

require 'spec_helper'
require 'votd/helper/command_line'

describe Votd::Helper::CommandLine do
  describe '#banner' do
    it 'prints a banner wrapped at the correct location' do
      expect($stdout).to receive(:puts).with("======\n foo  \n======")
      Votd::Helper::CommandLine.banner('foo', 6)
    end
  end

  describe '#word_wrap' do
    it 'wraps text at the specified column' do
      text = 'The quick brown fox jumps over the lazy dog.'
      expect(Votd::Helper::CommandLine.word_wrap(text, 20)).to eq "The quick brown fox\njumps over the lazy\ndog."
    end
  end
end
