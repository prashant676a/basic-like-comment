class LikesController < ApplicationController
  before_action :authenticate_user! # Ensure user is authenticated
  before_action :find_likeable
  before_action :find_like, only: [:destroy]

  def create
    if already_liked?
      flash[:notice] = "You can't like more than once"
    else
      @likeable.likes.create(user: current_user)
      flash[:notice] = "Liked successfully!"
    end
    redirect_to likeable_redirect_path
  end

  def destroy
    if !already_liked?
      flash[:notice] = "Cannot unlike"
    else
      @like.destroy
      flash[:notice] = "Unliked successfully!"
    end
    redirect_to likeable_redirect_path
  end

  private

  def find_likeable
    if params[:comment_id]
      @likeable = Comment.find_by(id: params[:comment_id])
    elsif params[:post_id]
      @likeable = Post.find_by(id: params[:post_id])
    end
  end

  def find_like
    @like = @likeable.likes.find(params[:id])
  end

  def already_liked?
    Like.where(user_id: current_user.id, likeable: @likeable).exists?
  end

  def likeable_redirect_path
    if @likeable.is_a?(Post)
      post_path(@likeable)
    elsif @likeable.is_a?(Comment)
      post_path(@likeable.commentable) # Assuming comments belong to a post
    else
      root_path
    end
  end
end
