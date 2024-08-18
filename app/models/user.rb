class User < ApplicationRecord
  has_one_attached :profile_picture
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable
  
  has_many :likes, dependent: :destroy
  has_many :posts, dependent: :destroy

  has_many :comments, dependent: :destroy
end
