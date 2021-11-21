module Types
  class GenreType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :description, String, null: false
    field :movies, [Types::MovieType], null: false    
    field :followers, [Types::UserType], null: false
  end
end
