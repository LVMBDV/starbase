class User < ApplicationRecord
  validates :email_address, presence: true, uniqueness: true
  has_secure_password
  has_secure_token :password_reset
end
