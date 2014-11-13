module Schemas
  module Fields
    class PassThroughField
      def errors(input)
        []
      end

      def parse(input)
        input
      end
    end
  end
end
