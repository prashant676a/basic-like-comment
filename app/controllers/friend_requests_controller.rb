class FriendRequestsController < ApplicationController
  
  def show_friends
    @friends = current_user.friends
  end

  def suggestions
    @suggested_users = current_user.suggested_users
  end

  def index
    @request_received_from = current_user.friend_requests_as_receiver.where(status: 'pending').map(&:requestor)
    @requests_sent_to = current_user.friend_requests_as_requestor.where(status: "pending").map(&:receiver)
  end

  def create
    @friendrequest = FriendRequest.new(friendrequest_params)
    @friendrequest.status = 'pending'

    if @friendrequest.save
      redirect_to friend_requests_path, notice: 'Friend request sent'
    else
      redirect_to suggestions_friend_requests_path, notice: 'Friend request could not be sent.'
    end
  end

  def update
    @request = FriendRequest.find(params[:id])
    # debugger

    if @request.update(status: 'accepted') 
      redirect_to show_friends_friend_requests_path, notice: "friend request accepted successfully."
    else
      redirect_to friend_requests_suggestions_path, notice: "could not be accepted"
    end

  end

  def destroy
    @friendrequest = FriendRequest.find(params[:id])
    @friendrequest.destroy

    redirect_to suggestions_friend_requests_path
  end

  private

  def friendrequest_params
    params.require(:friend_request).permit(:requestor_id, :receiver_id, :status)
  end

end
