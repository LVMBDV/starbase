module Mutations
  class SignUp < Mutations::BaseMutation
    argument :credentials, Types::CredentialsInput, required: true

    type Types::UserType

    def resolve(credentials:)
      user = User.create!(credentials.to_h)
      UserMailer.with(user: user).confirm_email.deliver_now
      user
    end
  end
end
