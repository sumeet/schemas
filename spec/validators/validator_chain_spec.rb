require "spec_helper"

describe Schemas::Validators::ValidatorChain do
  let(:validator_a) { double(:validator_a) }
  let(:validator_b) { double(:validator_b) }
  subject { described_class.new([validator_a, validator_b]) }

  it "combines errors from multiple validators" do
    validator_a.stub(:errors).with("input").and_return([:validation_error_a])
    validator_b.stub(:errors).with("input").and_return([:validation_error_b])
    subject.errors("input").should == [:validation_error_a, :validation_error_b]
  end
end
