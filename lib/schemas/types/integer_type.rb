module Schemas
  module Types
    class IntegerType
      def errors(string)
        begin
          Integer(string)
          []
        rescue ArgumentError
          [:not_an_integer]
        end
      end

      def parse(string)
        Integer(string)
      end
    end
  end
end
