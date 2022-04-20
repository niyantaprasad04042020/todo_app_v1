class User
  include Mongoid::Document
  include ActiveModel::SecurePassword

  field :first_name, type: String
  field :last_name, type: String
  field :email_id, type: String
  field :phone_no, type: String
  field :password_digest, type: String
  field :reset_password_token, type: String
  field :reset_password_sent_at, type: String

  has_secure_password

  def generate_password_token!
    self.reset_password_token   = generate_token
    self.reset_password_sent_at = Time.now.utc
    save!
  end

  def password_token_valid?
    (self.reset_password_sent_at + 4.hours) > Time.now.utc
  end

  def reset_password!(password)
    self.reset_password_token   = nil
    self.password = password
    save!
  end

  private

  def generate_token
    SecureRandom.hex(10)
  end
end
