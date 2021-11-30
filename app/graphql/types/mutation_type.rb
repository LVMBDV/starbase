module Types
  class MutationType < Types::BaseObject
    field :sign_up, mutation: Mutations::SignUp
    field :confirm_email, mutation: Mutations::ConfirmEmail
    field :sign_in, mutation: Mutations::SignIn
    field :follow_interest, mutation: Mutations::FollowInterest
    field :unfollow_interest, mutation: Mutations::UnfollowInterest
    field :request_password_reset, mutation: Mutations::RequestPasswordReset
    field :reset_password, mutation: Mutations::ResetPassword
  end
end
