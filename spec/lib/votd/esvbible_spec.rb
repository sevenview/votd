require "spec_helper"

describe "Votd::ESVBible" do
  it "raises a VotdError explaining the service is no longer supported" do
    expect { Votd::ESVBible.new }.to raise_error(
      Votd::VotdError,
      /no longer supported/
    )
  end

  it "mentions the replacement in the error message" do
    expect { Votd::ESVBible.new }.to raise_error(
      Votd::VotdError,
      /BibleGateway\.new\(:esv\)/
    )
  end
end
