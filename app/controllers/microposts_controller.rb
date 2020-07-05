# frozen_string_literal: true

class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i[create destroy]
  before_action :correct_user,   only: :destroy

  def index
    @microposts = Micropost.includes(:user).page(params[:page]).per(20)
    @popular_books = Book.popular
  end

  def show
    @micropost = Micropost.find(params[:id])
    @comments = @micropost.comments.includes(:user)
    @comment = @micropost.comments.build if logged_in?
  end

  def create
    @user = current_user
    @book = Book.find(micropost_params[:book_id])
    @micropost = current_user.microposts.build(micropost_params)
    flash[:danger] = '正しい内容を入力してください' unless @micropost.save
    redirect_to @book
  end

  def destroy
    @micropost.destroy
    flash[:success] = '学びメモを削除しました。'
    redirect_to request.referrer || root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit(:user_id, :book_id, :quoted_text, :content)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
