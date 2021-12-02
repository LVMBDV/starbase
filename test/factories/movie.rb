# frozen_string_literal: true

FactoryBot.define do
  factory :movie do
    original_title { Faker::Lorem.unique.sentence }
    description { Faker::Lorem.paragraph }

    transient do
      genres_count { Faker::Number.between(from: 1, to: 3) }
      roles_count { Faker::Number.between(from: 3, to: 10) }
    end

    after(:create) do |movie, evaluator|
      create_list(:genre, evaluator.genres_count, movies: [movie], movies_count: 0) if evaluator.genres_count > 0
      create_list(:role, evaluator.roles_count, movie: movie) if evaluator.roles_count > 0
    end
  end
end
