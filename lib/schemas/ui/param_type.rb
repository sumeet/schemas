module Schemas
  module UI
    class ParamType
      def self.new(type, is_required, validators)
        validator_chain = Validators::ValidatorChain.new(validators)
        type_with_validator = Types::TypeWithValidator.new(type, validator_chain)
        if is_required
          Fields::RequiredField.new(type_with_validator)
        else
          Fields::NullWhenBlankField.new(type_with_validator)
        end
      end
    end
  end
end
