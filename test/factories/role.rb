# frozen_string_literal: true

FactoryBot.define do
  factory :role do
    title { Faker::Lorem.word.titleize }
    movie
    star
  end
end
