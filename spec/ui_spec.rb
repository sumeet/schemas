require "spec_helper"

class IntegerType
  def errors(string)
    begin
      Integer(string)
      []
    rescue ArgumentError
      [:invalid_integer]
    end
  end

  def parse(string)
    Integer(string)
  end
end

class IsPositiveValidator
  def errors(parsed)
    return [:must_be_positive] if parsed < 1
    []
  end
end

describe Schemas::UI do
  it "works" do
    schema = Schemas::UI::Schema.define do
      param :id, required: true, type: IntegerType.new, validator: IsPositiveValidator.new
      param :name, required: false
    end

    d = {:id => "123"}
    schema.parse(d).should == {:id => 123, :name => nil}

    d = {:id => "123"}
    schema.parse(d).should == {:id => 123, :name => nil}

    d = {:id => "hotjava9"}
    schema.errors(d).should == {:id => [:invalid_integer]}

    d = {}
    schema.errors(d).should == {:id => [:required]}

    d = {:id => -1}
    schema.errors(d).should == {:id => [:must_be_positive]}
  end
end
