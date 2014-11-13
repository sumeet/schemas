module Schemas
  module Fields
    class MergedNamedFields
      def initialize(named_fields)
        @named_fields = named_fields
      end

      def errors(input_hash)
        @named_fields.map {|nv| nv.errors(input_hash)}.reduce({}, :merge)
      end

      def parse(input_hash)
        @named_fields.map {|nv| nv.parse(input_hash)}.reduce({}, :merge)
      end
    end
  end
end
