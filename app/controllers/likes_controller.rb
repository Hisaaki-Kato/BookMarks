class LikesController < ApplicationController
  before_action :logged_in_user

  def create
    @micropost = Micropost.find(params[:micropost_id])
    like = current_user.likes.build(micropost_id: params[:micropost_id])
    like.save
    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
    @micropost = Micropost.find(params[:micropost_id])
    like = Like.find_by(micropost_id: params[:micropost_id], user_id: current_user.id)
    like.destroy
    respond_to do |format|
      format.html
      format.js
    end
  end
end
