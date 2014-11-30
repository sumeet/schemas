module Schemas
  module Fields
    class FieldWithDefault
      def initialize(field, default)
        @field = field
        @default = default
      end

      def errors(input)
        return [] if input.blank?
        @field.errors(input)
      end

      def parse(input)
        return use_default if input.blank?
        @field.parse(input)
      end

      private

      def use_default
        @default.is_a?(Proc) ? @default.call : @default
      end
    end
  end
end
