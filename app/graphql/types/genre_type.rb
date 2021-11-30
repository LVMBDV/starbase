module Types
  class GenreType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :description, String, null: true
    field :movies, Types::MovieType.connection_type, null: false
    field :followers, [Types::UserType], null: false
  end
end
