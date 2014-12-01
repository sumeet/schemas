module Schemas
  module Fields
    class NamedFieldFromHash
      def initialize(name, field)
        @name = name
        @field = field
      end

      def errors(input_hash)
        input = get_value_from_hash(input_hash)
        errors = @field.errors(input)
        errors.any? ? {@name => errors} : {}
      end

      def parse(input_hash)
        input = get_value_from_hash(input_hash)
        {@name => @field.parse(input)}
      end

      private

      def get_value_from_hash(input_hash)
        input_hash.fetch(@name, Missing.new)
      end
    end
  end
end
