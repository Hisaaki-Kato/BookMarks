# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :logged_in_user, only: %i[create destroy]
  before_action :correct_user,   only: :destroy

  def create
    @micropost = Micropost.find(params[:micropost_id])
    @comment = @micropost.comments.build(comment_params)
    if @comment.save
      redirect_to @micropost
    else
      flash[:danger] = 'コメントを投稿できませんでした。'
      redirect_to @micropost
    end
  end

  def destroy
    @micropost = Micropost.find(params[:micropost_id])
    Comment.find(params[:comment_id]).destroy
    flash[:success] = 'コメントを削除しました。'
    redirect_to @micropost
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :content)
  end

  def correct_user
    comment = current_user.comments.where(id: params[:comment_id])
    redirect_to root_url if comment.blank?
  end
end
