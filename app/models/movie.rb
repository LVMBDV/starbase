class Movie < ApplicationRecord
  has_and_belongs_to_many :genres
  has_many :roles
  has_many :stars, through: :roles
end
