module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :email_address, String, null: false
    field :follows, [Types::InterestType], null: false
  end
end
