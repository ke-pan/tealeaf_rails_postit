class User < ActiveRecord::Base
  has_many :posts
  has_many :comments

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create
  validates :password, length: {minimum: 5, :if => :validate_password? }

  def validate_password?
    password.present?
  end

end