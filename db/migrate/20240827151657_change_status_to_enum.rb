class ChangeStatusToEnum < ActiveRecord::Migration[7.1]
  def changestatus

    remove_column :friend_requests, :status
    add_column :friend_requests, :status, :integer, default: 0, null: false
  end
end
