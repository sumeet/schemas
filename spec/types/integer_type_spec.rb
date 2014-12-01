require "spec_helper"

describe Schemas::Types::IntegerType do
  describe "#errors" do
    it "returns an error when the value is not an integer" do
      subject.errors("ab123").should == [:not_an_integer]
      subject.errors("123").should == []
    end
  end

  describe "#parse" do
    it "parses the string into an integer" do
      subject.parse("123").should == 123
    end
  end
end
