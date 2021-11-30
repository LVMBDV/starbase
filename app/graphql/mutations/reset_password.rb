module Mutations
  class ResetPassword < Mutations::BaseMutation
    argument :token, String, required: true
    argument :password, String, required: true

    field :errors, [String], null: true

    def resolve(token:, password:)
      user = User.find_by(password_reset: token)

      if user.present?
        if user.update(password: password)
          user.update(password_reset: nil)
          { errors: [] }
        else
          { errors: user.errors.full_messages }
        end
      else
        { errors: ['Invalid token'] }
      end
    end
  end
end
