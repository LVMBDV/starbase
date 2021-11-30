module Types
  class QueryType < Types::BaseObject
    include AuthenticationHelpers
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

    field :search_genre, Types::GenreType, null: true do
      argument :query, String, required: true
    end

    def search_genre(query:)
      Genre.where("title LIKE ?", "%#{query}%").first
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
        Star.where("full_name LIKE ?", "%#{name}%").limit(12)
      else
        Star.first(12)
      end
    end

    field :user, Types::UserType, null: true do
      argument :id, ID, required: true
    end

    def user(id:)
      user = User.find(id)
      raise GraphQL::ExecutionError, "You may not access another user's information" if user != current_user
      user
    end

    field :following_interest, Boolean, null: false do
      argument :interest_id, ID, required: true
      argument :interest_kind, Types::InterestKind, required: true
    end

    def following_interest(interest_id:, interest_kind:)
      Rails.logger.debug interest_kind.inspect
      current_user.present? and InterestKind.model_class(interest_kind).find(interest_id).followers.include?(current_user)
    end

    field :recommended_movies, [Types::MovieType], null: false

    def recommended_movies
      unless current_user.present?
        raise new GraphQL::ExecutionError, "You must be signed in to get recommended movies"
      end

      scores = {}

      current_user.follows.each do |follow|
        interest = follow.interest

        if interest.is_a?(Genre) or interest.is_a?(Star)
          interest.movies.each do |movie|
            scores[movie] = scores.fetch(movie, 0) + 1
          end
        end
      end

      scores.to_a.sort_by { |movie, score| score }.reverse.map(&:first).first(12)
    end
  end
end
