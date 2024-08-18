module FriendrequestsHelper
  def find_friend_request(user)
    FriendRequest.find_by(requestor: current_user, receiver: user) ||
    FriendRequest.find_by(requestor: user, receiver: current_user)
  end
end
