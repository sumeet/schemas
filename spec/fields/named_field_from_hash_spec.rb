require "spec_helper"

describe Schemas::Fields::NamedFieldFromHash do
  let(:underlying_field) { double(:underlying_field) }
  subject { described_class.new(:name, underlying_field) }

  describe "#errors" do
    it "delegates errors from the underlying field" do
      underlying_field.stub(:errors).with("input").and_return([:error])
      subject.errors(name: "input").should == {name: [:error]}
    end

    it "gets errors for a blank Missing object when the value is Missing" do
      underlying_field.stub(:errors).
        with(an_instance_of(Schemas::Fields::Missing)).and_return([:error])
      subject.errors({}).should == {name: [:error]}
    end

    it "returns no errors when there are none" do
      underlying_field.stub(:errors).with("input").and_return([])
      subject.errors({name: "input"}).should == {}
    end
  end

  describe "#parse" do
    it "delegates parsing from the underlying field" do
      underlying_field.stub(:parse).with("input").and_return("parsed")
      subject.parse(name: "input").should == {name: "parsed"}
    end

    it "parses a Missing when there is no value provided" do
      underlying_field.stub(:parse).
        with(an_instance_of(Schemas::Fields::Missing)).
        and_return("parsed missing")
      subject.parse({}).should == {name: "parsed missing"}
    end
  end
end
