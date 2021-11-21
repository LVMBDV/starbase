module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :movie, Types::MovieType, null: false do
      argument :id, ID, required: true
    end

    def movie(id:)
      Movie.find(id)
    end

    field :movies, [Types::MovieType], null: false do
      argument :genre, String, required: false
    end

    def movies(genre: nil)
      if genre.present?
        Genre.find_by(title: genre).movies
      else
        Movie.all
      end
    end

    field :search_movies, [Types::MovieType], null: false do
      argument :query, String, required: true
    end

    def search_movies(query:)
      # I didn't want to waste too much time on this as it wasn't even in the requirements
      Movie.where("original_title LIKE ?", "%#{query}%")
    end

    field :genre, Types::GenreType, null: false do
      argument :id, ID, required: true
    end

    def genre(id:)
      Genre.find(id)
    end

    field :genres, [Types::GenreType], null: false

    def genres
      Genre.all
    end

    field :star, Types::StarType, null: false do
      argument :id, ID, required: true
    end

    def star(id:)
      Star.find(id)
    end

    field :search_stars, [Types::StarType], null: false do
      argument :name, String, required: false
    end

    def search_stars(name: nil)
      if name.present?
        Star.where("full_name LIKE ?", "%#{name}%")
      else
        Star.all
      end
    end
  end
end
