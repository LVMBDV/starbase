module Types
  class StarType < Types::BaseObject
    field :id, ID, null: false
    field :full_name, String, null: false
    field :biography, String, null: false
    field :movies, [Types::MovieType], null: false
    field :followers, [Types::UserType], null: false
  end
end
