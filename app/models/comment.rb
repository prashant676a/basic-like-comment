class Comment < ApplicationRecord
  belongs_to :user
  has_many :likes, as: :likeable , dependent: :destroy

  # belongs_to :post
  belongs_to :commentable, polymorphic: true
end
