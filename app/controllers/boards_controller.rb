class BoardsController < ApplicationController
  before_action :logged_in_user, only: [:create, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update, :destroy]

  def new
  end

  def create
    @user = current_user
    @book = Book.find(micropost_params[:book_id])
    @board = current_user.boards.build(board_params)
    if @board.save
      flash[:success] = "board created!"
      redirect_to @book
    else
      flash[:danger] = "正しい内容を入力してください"
      redirect_to @book
    end
  end

  def edit
    @board = Board.find(params[:id])
  end

  def update
    @user = current_user
    @board = Board.find(params[:id])
    if @board.update_attributes(board_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @board.destroy
    flash[:success] = "board deleted"
    redirect_to request.referrer || root_url
  end

  private

    def board_params
      params.require(:board).permit(:content, :book_id)
    end

    def correct_user
      @board = current_user.boards.find_by(id: params[:id])
      redirect_to root_url if @board.nil?
    end
end
