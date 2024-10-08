class User < ApplicationRecord
  around_destroy :log_destroy_operation
  around_create :log_creation
  
  include Gravtastic
  gravtastic

  has_one_attached :profile_picture
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable
  
  has_many :likes, dependent: :destroy
  has_many :posts, dependent: :destroy
  
  has_many :shares
  has_many :shared_posts, through: :shares, source: :post

  has_many :comments, dependent: :destroy


  has_many :friend_requests_as_requestor, foreign_key: :requestor_id,\
    class_name: :FriendRequest
  
  has_many :friend_requests_as_receiver, foreign_key: :receiver_id, \
    class_name: :FriendRequest
  
  def friends
    # when you're requestor look for receiver
    friend_requests_as_requestor.where(status: "accepted").map(&:receiver) +
    friend_requests_as_receiver.where(status: "accepted").map(&:requestor)
  end

  def suggested_users
    # returns array of user objects that are not related with current_user in terms of friend request
    User.where.not(id: id) # Exclude current user
      .where.not(id: friend_requests_as_requestor.pluck(:receiver_id)) # Exclude users whom the current user has sent friend requests to
      .where.not(id: friend_requests_as_receiver.pluck(:requestor_id)) # Exclude users who have sent friend requests to the current user
  end

  private
  def log_destroy_operation
    Rails.logger.info("About to destroy user with ID #{id}")
    yield
    Rails.logger.info("User with ID #{id} destroyed successfully")
  end

  def log_creation
    Rails.logger.info("Creating user with email: #{email}")
    yield
    Rails.logger.info("User created with email: #{email}")
  end

end
