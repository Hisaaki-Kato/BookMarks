class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_back_or user
    else
      flash.now[:danger] = 'メールアドレス/パスワードが正しくありません。'
      render 'new'
    end
  end

  def test_create
    tester = User.find_by(email: "test@example.com")
    log_in tester
    redirect_to tester
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
