class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def index
    @microposts = Micropost.paginate(page: params[:page])
  end
  
  def show
    @micropost = Micropost.find(params[:id])
    @comments = @micropost.comments.includes(:user)
    if logged_in?
      @comment = @micropost.comments.build
    end
  end

  def create
    @user = current_user
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to @user
    else
      flash[:danger] = "正しい内容を入力してください"
      redirect_to @user
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end