module Mutations
  class SignUp < Mutations::BaseMutation
    argument :credentials, Types::CredentialsInput, required: true

    field :errors, [String], null: true

    def resolve(credentials:)
      user = User.create(credentials.to_h)

      Rails.logger.debug user.inspect
      if (user.id.present?)
        UserMailer.with(user: user).confirm_email.deliver_now
        { errors: [] }
      else
        { errors: user.errors.full_messages }
      end
    end
  end
end
