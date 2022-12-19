class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :content, presence: true, length: { minimum: 3, maximum: 2000 }
end
