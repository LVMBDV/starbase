class Genre < ApplicationRecord
  has_and_belongs_to_many :movies
  has_many :follows, as: :interest
  has_many :followers, through: :follows, source: :user
end
