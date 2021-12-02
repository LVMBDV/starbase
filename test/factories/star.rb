# frozen_string_literal: true

FactoryBot.define do
  factory :star do
    full_name { Faker::Name.name }
    biography { Faker::Lorem.paragraph }

    transient do
      roles_count { 0 }
    end

    after(:create) do |star, evaluator|
      create_list(:role, evaluator.roles_count, star: star) if evaluator.roles_count > 0
    end
  end
end
