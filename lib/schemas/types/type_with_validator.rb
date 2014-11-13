module Schemas
  module Types
    class TypeWithValidator
      def initialize(type, validator)
        @type = type
        @validator = validator
      end

      def errors(input)
        type_errors = @type.errors(input)
        return type_errors if type_errors.any?

        parsed = @type.parse(input)
        @validator.errors(parsed)
      end

      def parse(input)
        @type.parse(input)
      end
    end
  end
end
