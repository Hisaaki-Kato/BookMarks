class BoardsController < ApplicationController
  before_action :logged_in_user, only: [:create, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update, :destroy]

  def create
    @book = Book.find(board_params[:book_id])
    @board = current_user.boards.build(board_params)
    if @board.save
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
      flash[:success] = "学びボードが更新されました。"
      redirect_to @board.book
    else
      render 'edit'
    end
  end

  def destroy
    @board.destroy
    flash[:success] = "学びボードを削除しました。"
    redirect_to request.referrer || root_url
  end

  private

    def board_params
      params.require(:board).permit(:title, :content, :book_id)
    end

    def correct_user
      @board = current_user.boards.find_by(id: params[:id])
      redirect_to root_url if @board.nil?
    end
end
