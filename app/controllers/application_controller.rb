# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = 'ログインが必要です。'
      redirect_to login_url
    end
  end

  def test_user
    if current_user.name == 'Test User'
      redirect_to(root_url)
      flash[:danger] = 'テストユーザーではユーザー情報の編集はできません。'
    end
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
