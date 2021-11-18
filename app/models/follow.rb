class Follow < ApplicationRecord
  belongs_to :interest, polymorphic: true
  belongs_to :user
end
