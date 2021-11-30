module Mutations
  class RequestPasswordReset < Mutations::BaseMutation
    argument :email_address, String, required: true

    field :errors, [String], null: true

    def resolve(email_address:)
      user = User.find_by(email_address: email_address)

      if user.present?
        user.regenerate_password_reset
        UserMailer.with(user: user).reset_password.deliver_now

        if user.save
          { errors: [] }
        else
          { errors: user.errors.full_messages }
        end
      else
        { errors: ['User not found'] }
      end
    end
  end
end
