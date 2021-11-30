module Mutations
  class UnfollowInterest < BaseMutation
    include AuthenticationHelpers

    argument :interest_id, ID, required: true
    argument :interest_kind, Types::InterestKind, required: true

    field :errors, [String], null: false

    def resolve(interest_id:, interest_kind:)
      unless current_user.present?
        { errors: ["You must be signed in to follow an interest"] }
      else
        interest = Types::InterestKind.model_class(interest_kind).find(interest_id)
        follow = Follow.find_by(interest: interest, user: current_user)
        if follow.present?
          follow.destroy
          { errors: [] }
        else
          { errors: ["You are not following this interest"] }
        end
      end
    end
  end
end
