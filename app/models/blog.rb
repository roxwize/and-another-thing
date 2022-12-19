class Blog < ApplicationRecord
  validates :name, uniqueness: true, presence: true, length: { maximum: 30 }
  has_many :posts
  has_many :kudos
  belongs_to :user
end
