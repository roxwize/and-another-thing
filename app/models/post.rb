class Post < ApplicationRecord
  belongs_to :blog
  has_many :comments

  validates :title, presence: true, length: { minimum: 2, maximum: 30 }
  validates :content, presence: true, length: { minimum: 10, maximum: 5000 }
end
