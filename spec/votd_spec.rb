require 'spec_helper'

describe Votd do
  describe "#hello" do
    it "outputs 'Hello World'" do
      Votd.hello.should == "Hello World"
    end
  end
end