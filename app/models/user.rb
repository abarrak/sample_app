class User < ActiveRecord::Base

  before_save { self.email = self.email.downcase }
  
  validates :name, presence: true, length: { maximum: 50, minimum: 3 }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255, minimum: 8 }, 
                    format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  validates :password, length: { minimum: 6 }, allow_blank: true

  has_secure_password

  # Returns the hash digest of the given string.
  def self.digest string 
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create string, cost: cost
  end

  # Returns a random token.
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # Virtual attribure only for remember token.
  attr_accessor :remember_token

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute :remember_digest, User.digest(self.remember_token)
  end

  # Returns true if the given token matches the digest.
  def authenticated? remember_token
    return false if self.remember_digest.nil?
    BCrypt::Password.new(self.remember_digest).is_password? remember_token
  end

  # Forgets a user.
  def forget
    update_attribute :remember_digest, nil
  end

end
