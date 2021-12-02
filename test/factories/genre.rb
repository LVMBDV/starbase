# frozen_string_literal: true

FactoryBot.define do
  factory :genre do
    title { Faker::Lorem.unique.word.titleize }
    description { Faker::Lorem.paragraph }

    transient do
      movies_count { Faker::Number.between(from: 3, to: 5) }
    end

    after(:create) do |genre, evaluator|
      create_list(:movie, evaluator.movies_count, genres: [genre], genres_count: 0) if evaluator.movies_count > 0
    end
  end
end
