class FriendRequest < ApplicationRecord
  # schema
  # requestor-id: integer
  # receiver-id: integer
  # status: string

  belongs_to :requestor, class_name: 'User', foreign_key: "requestor_id"
  belongs_to :receiver, class_name: 'User'

end
