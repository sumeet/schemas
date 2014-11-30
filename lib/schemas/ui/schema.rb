module Schemas
  module UI
    class Schema
      def initialize
        @params = []
      end

      def self.define(&block)
        schema = new
        schema.instance_eval(&block)
        schema
      end

      def parse(input)
        merged_named_fields.parse(input)
      end

      def errors(input)
        merged_named_fields.errors(input)
      end

      def required(name, *args)
        type_with_validator = construct_field_from_params(*args)
        required_field = Fields::RequiredField.new(type_with_validator)
        @params << Fields::NamedFieldFromHash.new(name, required_field)
      end

      def optional(name, *args)
        type_with_validator = construct_field_from_params(*args)
        optional_field = Fields::NullWhenBlankField.new(type_with_validator)
        @params << Fields::NamedFieldFromHash.new(name, optional_field)
      end

      private

      def construct_field_from_params(type: Fields::PassThroughField.new,
                                      required: true, validator: nil,
                                      validators: [])
        validator_chain = Validators::ValidatorChain.new(Array(validator) +
                                                         validators)
        Types::TypeWithValidator.new(type, validator_chain)
      end

      def merged_named_fields
        Fields::MergedNamedFields.new(@params)
      end
    end
  end
end
