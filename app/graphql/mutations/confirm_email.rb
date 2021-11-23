module Mutations
  class ConfirmEmail < Mutations::BaseMutation
    argument :token, String, required: true

    field :user, Types::UserType, null: true
    field :errors, [String], null: true

    def resolve(token:)
      user = User.find_by(email_confirmation: token)
      if user.nil?
        { user: nil, errors: ["User not found"] }
      elsif user.email_confirmation_sent_at >= Time.now.since(Rails.application.config.email_confirmation_expires_in)
        user.regenerate_email_confirmation
        user.save!
        UserMailer.with(user: user).confirm_email.deliver_later
        { user: nil, errors: ["Token expired"] }
      else
        user.email_confirmed = true
        user.save!
        { user: user, errors: [] }
      end
    end
  end
end
