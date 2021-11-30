class User < ApplicationRecord
  has_many :follows

  validates :email_address, presence: true, uniqueness: true
  has_secure_password :password
  has_secure_token :email_confirmation
  has_secure_token :password_reset
end
