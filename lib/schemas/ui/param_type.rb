module Schemas
  module UI
    class ParamType
      def initialize(type, is_required, validators)
        @is_required = is_required
        validator_chain = Schemas::Validators::ValidatorChain.new(validators)
        @type_with_validator =
          Schemas::Types::TypeWithValidator.new(type, validator_chain)
      end

      def errors(input)
        type_with_blank_behavior.errors(input)
      end

      def parse(input)
        type_with_blank_behavior.parse(input)
      end

      private

      def type_with_blank_behavior
        if @is_required
          Schemas::Fields::RequiredField.new(@type_with_validator)
        else
          Schemas::Fields::NullWhenBlankField.new(@type_with_validator)
        end
      end
    end
  end
end
