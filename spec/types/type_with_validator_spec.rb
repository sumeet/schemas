require "schemas/types/type_with_validator"

describe Schemas::Types::TypeWithValidator do
  let(:type) { double(:type, errors: []) }
  let(:validator) { double(:validator) }
  subject { described_class.new(type, validator) }

  describe "#errors" do
    it "returns type errors if there are any" do
      type.stub(:errors).with("input").and_return([double(:type_error)])
      subject.errors("input").should == type.errors("input")
    end

    it "validates the parsed input and returns any validation errors" do
      validator.stub(:errors).with("parsed").
        and_return([double(:validation_error)])
      type.stub(:parse).with("input").and_return("parsed")

      subject.errors("input").should == validator.errors("parsed")
    end
  end

  describe "#parse" do
    it "parses input with the type" do
      type.stub(:parse).with("input").and_return("parsed")
      subject.parse("input").should == type.parse("input")
    end
  end
end
