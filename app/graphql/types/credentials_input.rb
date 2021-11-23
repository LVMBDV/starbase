module Types
  class CredentialsInput < Types::BaseInputObject
    argument :email_address, String, required: true
    argument :password, String, required: true
  end
end
