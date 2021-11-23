module Types
  class MutationType < Types::BaseObject
    field :sign_up, mutation: Mutations::SignUp
    field :confirm_email, mutation: Mutations::ConfirmEmail
    field :sign_in, mutation: Mutations::SignIn
    field :follow_interest, mutation: Mutations::FollowInterest
  end
end
