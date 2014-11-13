module Schemas
  module Validators
    class ValidatorChain
      def initialize(validators)
        @validators = validators
      end

      def errors(obj)
        @validators.map { |v| v.errors(obj) }.flatten
      end
    end
  end
end
