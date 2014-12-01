require "spec_helper"

describe Schemas::Fields::MergedNamedFields do
  let(:named_field_a) { double(:named_field_a) }
  let(:named_field_b) { double(:named_field_b) }
  subject { described_class.new([named_field_a, named_field_b]) }

  it "merges together errors from underlying named fields" do
    input_hash = {a: "input_a", b: "input_b"}
    named_field_a.stub(:errors).with(input_hash).and_return(a: [:error_for_a])
    named_field_b.stub(:errors).with(input_hash).and_return(b: [:error_for_b])
    subject.errors(input_hash).should == {a: [:error_for_a], b: [:error_for_b]}
  end

  it "merges together parsed values from underlying named fields" do
    input_hash = {a: "input_a", b: "input_b"}
    named_field_a.stub(:parse).with(input_hash).and_return(a: "parsed_a")
    named_field_b.stub(:parse).with(input_hash).and_return(b: "parsed_b")
    subject.parse(input_hash).should == {a: "parsed_a", b: "parsed_b"}
  end
end
