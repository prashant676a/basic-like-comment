class Post < ApplicationRecord

  has_many :likes, dependent: :destroy, as: :likeable
  belongs_to :user

  has_many :shares
  has_many :shared_by_users, through: :shares, source: :user

  has_many :comments, dependent: :destroy, as: :commentable

  def is_creator?(user)
    self.user_id == user.id ? true : false
  end

  scope :visible_to, ->(user) { where(user: user.friends + [user]).order(updated_at: :desc) }

   # Attachments
   has_many_attached :images
  
   # Validation
   validates :title, :body, presence: true
  #  validates :images, content_type: { in: %w[image/jpeg image/png image/gif], message: 'must be a JPEG, PNG, or GIF' }, size: { less_than: 5.megabytes , message: 'should be less than 5MB' }
end
