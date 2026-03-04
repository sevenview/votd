# frozen_string_literal: true

require "spec_helper"

describe "Votd::VERSION" do
  it "has a valid semver VERSION number" do
    expect(Votd::VERSION).to match(/\A\d+\.\d+\.\d+\z/)
  end
end
