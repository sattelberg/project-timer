class User < ApplicationRecord
  has_many:tasks
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  has_secure_password
  validates :password, presence: true, length: { minimum: 3 }
end
