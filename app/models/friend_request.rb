class FriendRequest < ApplicationRecord
  # schema
  # requestor-id: integer
  # receiver-id: integer
  # status: : enum

  belongs_to :requestor, class_name: 'User', foreign_key: "requestor_id"
  belongs_to :receiver, class_name: 'User'

  enum :status, pending: 0, accepted: 1
end
