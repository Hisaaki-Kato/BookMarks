class LikesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :not_owner,      only: :create
  before_action :correct_user,   only: :destroy

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

  private

    def not_owner
      micropost = Micropost.find(params[:micropost_id])
      redirect_to root_url if micropost.user == current_user
    end

    def correct_user
      like = Like.where(micropost_id: params[:micropost_id], user_id: current_user.id)
      redirect_to root_url if like.blank?
    end
end
