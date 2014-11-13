module Schemas
  module Fields
    class NamedFieldFromHash
      def initialize(name, field)
        @name = name
        @field = field
      end

      def errors(input_hash)
        input = input_hash.fetch(@name, Missing.new)
        errors = @field.errors(input)
        errors.any? ? {@name => errors} : {}
      end

      def parse(input_hash)
        input = input_hash.fetch(@name, Missing.new)
        {@name => @field.parse(input)}
      end
    end
  end
end
