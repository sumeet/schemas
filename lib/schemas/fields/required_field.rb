module Schemas
  module Fields
    class RequiredField
      def initialize(field)
        @field = field
      end

      def errors(input)
        return [:required] if input.blank?
        @field.errors(input)
      end

      def parse(input)
        @field.parse(input)
      end
    end
  end
end
