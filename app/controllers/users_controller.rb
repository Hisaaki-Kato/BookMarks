# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[index edit update destroy
                                          following followers]
  before_action :correct_user,   only: %i[edit update]
  before_action :test_user,      only: %i[edit update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.includes(:user).page(params[:page])
    if logged_in?
      @read_books = @user.read_books
      @read_book = current_user.read_books.build
      @feed_items = current_user.feed
      @boards = @user.boards.includes(:user)
      @like_microposts = @user.like_microposts.includes(user: :likes)
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = 'ようこそ!BookMarksへ!'
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'プロフィールが更新されました。'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'ユーザーを削除しました。'
    redirect_to users_url
  end

  def following
    @title = 'フォローしているユーザー'
    @user  = User.find(params[:id])
    @users = @user.following.page(params[:page])
    @count = @user.following.count
    render 'show_follow'
  end

  def followers
    @title = 'フォロワー'
    @user  = User.find(params[:id])
    @users = @user.followers.page(params[:page])
    @count = @user.followers.count
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile, :picture,
                                 :password, :password_confirmation)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
