require "spec_helper"

describe Schemas::Fields::FieldWithDefault do
  let(:blank_input) { "   " }
  let(:field) { double(:field) }
  let(:default) { nil }
  subject { described_class.new(field, default) }

  describe "#errors" do
    it "returns no errors if the input is blank" do
      subject.errors(blank_input).should == []
    end

    it "it delegates to the underlying field when a value's provided" do
      field.stub(:errors).with("input").and_return([:error])
      subject.errors("input").should == [:error]
    end
  end

  describe "#parse" do
    context "when there isn't a value" do
      context "when the default is a lambda" do
        let(:default) { lambda { 123 } }

        it "returns the value from calling the block" do
          subject.parse(blank_input).should == 123
        end
      end

      context "when the default is a value" do
        let(:default) { "a value" }

        it "returns the value" do
          subject.parse(blank_input).should == "a value"
        end
      end
    end

    it "it delegates to the underlying field when a value's provided" do
      field.stub(:parse).with("input").and_return("parsed")
      subject.parse("input").should == "parsed"
    end
  end
end
