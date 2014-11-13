module Schemas
  module UI
    class Param
      def initialize(name, type)
        @field = Schemas::Fields::NamedFieldFromHash.new(name, type)
      end

      def errors(input_hash)
        @field.errors(input_hash)
      end

      def parse(input_hash)
        @field.parse(input_hash)
      end
    end
  end
end
