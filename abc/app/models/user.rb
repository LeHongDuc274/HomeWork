class User < ApplicationRecord
  has_many :microposts
  attr_accessor :remember_token,:activation_token,:reset_token

  validates :name ,presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  before_save {self.email = email.downcase}
  before_create :create_activation_digest
  validates :email ,presence: true, 
  uniqueness: { case_sensitive: false },
  format: {with: VALID_EMAIL_REGEX}
  has_secure_password
  validates :password,  presence: true, length: { minimum:  6 } ,allow_blank:  true

  def feed
    Micropost.where("user_id  = ?", id)
  end
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
    BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  def authenticated?(attribute, token)
        digest  = send("#{attribute}_digest") 
        return  false if  digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end
  def forget
    update_attribute(:remember_digest, nil)
  end
  def downcase_email
    self.email  = email.downcase
  end
  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest  = User.digest(activation_token)
  end



  def create_reset_digest
    self.reset_token  = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at,  Time.zone.now)
end
end
