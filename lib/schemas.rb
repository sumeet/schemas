require 'active_support'
require 'active_support/core_ext/object/blank'

# fields
require "schemas/fields/field_with_default"
require "schemas/fields/merged_named_fields"
require "schemas/fields/missing"
require "schemas/fields/named_field_from_hash"
require "schemas/fields/pass_through_field"
require "schemas/fields/required_field"

# ui
require "schemas/ui/schema.rb"

# validators
require "schemas/validators/validator_chain.rb"

# types
require "schemas/types/integer_type.rb"
require "schemas/types/type_with_validator.rb"

module Schemas
  def self.define(*args, &block)
    Schemas::UI::Schema.define(*args, &block)
  end
end
