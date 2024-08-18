class Post < ApplicationRecord
  has_many :likes, dependent: :destroy
  belongs_to :user
  has_many :comments, dependent: :destroy

  def is_creator?(user)
    self.user_id == user.id ? true : false
  end
end
