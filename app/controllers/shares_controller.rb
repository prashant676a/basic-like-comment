class SharesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @share = current_user.shares.build(post: @post)

    if @share.save
      redirect_to @post, notice: 'Post shared successfully.'
    else
      redirect_to @post, alert: 'Unable to share post.'
    end
  end

  def destroy
    @share = current_user.shares.find(params[:id])
    @post = @share.post
    @share.destroy

    redirect_to @post, notice: 'Share removed successfully.'
  end
end

