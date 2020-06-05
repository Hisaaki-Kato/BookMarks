class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def index
    @microposts = Micropost.includes(:user).paginate(page: params[:page])
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
    @book = Book.find(micropost_params[:book_id])
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to @book
    else
      flash[:danger] = "正しい内容を入力してください"
      redirect_to @book
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
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