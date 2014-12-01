require "spec_helper"

describe Schemas::Fields::RequiredField do
  let(:field) { double(:field) }
  subject { described_class.new(field) }

  describe "#errors" do
    it "returns an error if the input is blank" do
      subject.errors("    ").should == [:required]
    end

    it "delegates to the underlying field's errors otherwise" do
      field.stub(:errors).with("input").and_return([:error])
      subject.errors("input").should == [:error]
    end
  end

  describe "#parse" do
    it "delegates to the underlying field's parse" do
      field.stub(:parse).with("input").and_return("parsed")
      subject.parse("input").should == "parsed"
    end
  end
end
