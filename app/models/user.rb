class User < ActiveRecord::Base

  attr_accessor :password, :confirm_password
  before_save :encrypt_password, :if => Proc.new {|user| user.confirm_password}

  has_many :short_urls, dependent: :destroy

  validates :password, confirmation: true, on: :create
  validates :confirm_password, presence: true, on: :create
  validates :email, presence: true, on: :create
  validates :email, uniqueness: { case_sensitive: false }
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  def ensure_authentication_token!
    if self.auth_token.blank?
      self.auth_token = generate_authentication_token
      self.save
    end
  end

  def generate_authentication_token
    loop do
      token = generate_secure_token_string
      break token unless User.where(auth_token: token).first
    end
  end

  def reset_authentication_token!
    self.auth_token = generate_authentication_token
  end

  def is_password?(password)
    BCrypt::Password.new(self.encrypted_password) == password
  end

  private

  def generate_secure_token_string
    SecureRandom.urlsafe_base64(25).tr('lIO0', 'sxyz')
  end

  def encrypt_password
    self.encrypted_password = BCrypt::Password.create(self.password)
  end

end
