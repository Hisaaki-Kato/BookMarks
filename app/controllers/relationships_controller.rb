# frozen_string_literal: true

class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: :destroy

  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  private

  def correct_user
    follower = Relationship.find(params[:id]).follower
    redirect_to root_url if current_user != follower
  end
end
