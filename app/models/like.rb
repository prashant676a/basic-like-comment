class Like < ApplicationRecord
  belongs_to :likeable, polymorphic: true
  
  belongs_to :user

  # Validations
  validates :user_id, uniqueness: { scope: :likeable_id }
end
