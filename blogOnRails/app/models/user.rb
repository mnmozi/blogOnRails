class User < ApplicationRecord
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :password_digest, presence: true
    validates :name, presence: true
    has_many :posts
    has_many :comments
    has_one_attached :image
    has_secure_password
end
