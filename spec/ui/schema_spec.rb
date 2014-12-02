require "spec_helper"

describe Schemas::UI::Schema do
  subject { described_class }

  it "can define required params" do
    schema = subject.define do
      required :name
    end
    schema.errors({}).should == {name: [:required]}
  end

  it "can have define optional params that have defaults" do
    schema = subject.define do
      optional :name, default: lambda { 4 },
               type: Schemas::Types::IntegerType.new
    end

    schema.parse(name: "12").should == {name: 12}
    schema.parse({}).should == {name: 4}
  end

  it "requires a default for optional params" do
    expect do
      schema = subject.define do
        optional :name
      end
    end.to raise_exception /optional requires a default: param/
  end

  it "can specify a type" do
    schema = subject.define do
      required :name, type: Schemas::Types::IntegerType.new
    end

    schema.parse({name: "1"}).should == {name: 1}
    schema.errors({name: "notanumber"}).should == {name: [:not_an_integer]}
  end

  it "can specify validations" do
    schema = subject.define do
      required :name, type: Schemas::Types::IntegerType.new,
               validator: ValueMustBePositive.new
    end
    schema.errors({name: "-1"}).should == {name: [:must_be_positive]}
  end

  it "can specify multiple validators" do
    schema = subject.define do
      required :name, type: Schemas::Types::IntegerType.new,
               validators: [ValueMustBePositive.new, ValueMustBeEven.new]
    end
    schema.errors({name: "-2"}).should == {name: [:must_be_positive]}
    schema.errors({name: "1"}).should == {name: [:must_be_even]}
    schema.errors({name: "-1"}).should == {name: [:must_be_positive,
                                                  :must_be_even]}
  end

  it "raises an exception when parsing when there are errors" do
    schema = subject.define do
      required :name
    end
    expect do
      schema.parse({})
    end.to raise_exception(Schemas::UI::Schema::CannotParseWhenThereAreErrors)
  end
end

class ValueMustBePositive
  def errors(value)
    return [:must_be_positive] if value < 1
    []
  end
end

class ValueMustBeEven
  def errors(value)
    return [:must_be_even] if value % 2 != 0
    []
  end
end
