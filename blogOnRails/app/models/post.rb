class Post < ApplicationRecord
  validates :title, presence: true, length: { minimum: 3}
  validates :body, presence: true, length: { minimum: 10}
  validates :user, presence: true
  belongs_to :user
  has_many :comments
  has_and_belongs_to_many :tags
  validates :tags, presence: true
  
end
