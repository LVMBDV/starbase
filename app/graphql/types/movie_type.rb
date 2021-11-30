module Types
  class MovieType < Types::BaseObject
    field :id, ID, null: false
    field :original_title, String, null: false
    field :description, String, null: false
    field :release_date, String, null: false
    field :genres, [Types::GenreType], null: false
    field :stars, [Types::StarType], null: false
    field :followers, [Types::UserType], null: false
  end
end
