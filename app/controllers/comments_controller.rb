# app/controllers/comments_controller.rb
class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :authorize_comment, only: [:edit, :update, :destroy]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @post, notice: 'Comment was successfully created.'
    else
      redirect_to @post, alert: 'Error creating comment.'
    end
  end

  def show
    
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to @comment.commentable, notice: 'Comment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    # debugger
    @comment.destroy
    redirect_to @post, notice: 'Comment was successfully deleted.'
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def authorize_comment
    redirect_to @comment.post, alert: 'Not authorized' unless @comment.user == current_user
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end

