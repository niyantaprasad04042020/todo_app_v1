class User
  include Mongoid::Document
  include ActiveModel::SecurePassword

  field :first_name, type: String
  field :last_name, type: String
  field :email_id, type: String
  field :phone_no, type: String
  field :password_digest, type: String

  has_secure_password
end
