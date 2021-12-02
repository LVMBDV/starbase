# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email_address { Faker::Internet.email }
    password { Faker::Internet.password }

    after(:create) { |user| user.update(email_confirmed: true) }
  end
end
