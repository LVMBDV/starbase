module Mutations
  class FollowInterest < BaseMutation
    include AuthenticationHelpers

    argument :interest_id, ID, required: true
    argument :interest_kind, String, required: true

    field :interest, Types::InterestType, null: true
    field :errors, [String], null: false

    def resolve(interest_id:, interest_kind:)
      unless current_user.present?
        { interest: nil, errors: ["You must be signed in to follow an interest"] }
      else
        interest = interest_kind.model_class.find(interest_id)
        interest.followers << current_user
        interest.save!
        { interest: interest, errors: [] }
      end
    end
  end
end
