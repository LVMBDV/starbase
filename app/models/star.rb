class Star < ApplicationRecord
  has_many :roles
  has_many :movies, through: :roles
  has_many :follows, as: :interest
  has_many :followers, through: :follows, source: :user
end
