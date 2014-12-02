describe Schemas do
  it "exports `Schemas::UI::Schema.define` as `define`" do
    schema = Schemas.define do
      optional :name, default: lambda { 123 }
    end
    schema.parse({}).should == {name: 123}
  end
end
