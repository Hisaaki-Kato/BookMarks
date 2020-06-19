# frozen_string_literal: true

module SessionsHelper
  def log_in_as(user)
    session[:user_id] = user.id
  end

  def is_logged_in?
    !session[:user_id].nil?
  end
end
