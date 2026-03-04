# frozen_string_literal: true

require 'spec_helper'

describe Votd::VotdError do
  it 'is a subclass of StandardError' do
    expect(Votd::VotdError.new).to be_a(StandardError)
  end
end

describe Votd::InvalidBibleVersion do
  it 'is a subclass of VotdError' do
    expect(Votd::InvalidBibleVersion.new).to be_a(Votd::VotdError)
  end
end
