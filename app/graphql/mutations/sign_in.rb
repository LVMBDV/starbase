module Mutations
  class SignIn < Mutations::BaseMutation
    include AuthenticationHelpers

    argument :credentials, Types::CredentialsInput, required: true

    field :errors, [String], null: true

    def resolve(credentials:)
      user = User.find_by(email_address: credentials.email_address)
      if user.nil? || !user.authenticate(credentials.password)
        { errors: ["Invalid credentials"] }
      elsif !user.email_confirmed
        { errors: ["Email not confirmed yet"] }
      else
        sign_in_as(user)
        { errors: [] }
      end
    end
  end
end
