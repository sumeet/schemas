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

      def param(name, type: Schemas::Fields::PassThroughField.new,
                required: true, validator: [], validators: [])
        validators = Array(validator) + validators
        type = ParamType.new(type, required, validators)
        @params << Param.new(name, type)
      end

      private

      def merged_named_fields
        Schemas::Fields::MergedNamedFields.new(@params)
      end
    end
  end
end
