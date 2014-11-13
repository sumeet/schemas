module Schemas
  module Fields
    class NullWhenBlankField
      def initialize(field)
        @field = field
      end

      def errors(input)
        return [] if input.blank?
        @field.errors(input)
      end

      def parse(input)
        return nil if input.blank?
        @field.parse(input)
      end
    end
  end
end
