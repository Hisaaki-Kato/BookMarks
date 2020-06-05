class BooksController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]
  # before_action :admin_user,     only: :destroy  ##メソッドを定義する必要あり

  def index
    @books = Book.all.paginate(page: params[:page])
  end

  def show
    @book = Book.find(params[:id])
    @microposts = @book.microposts.includes(:user)
    if logged_in?
      @micropost = current_user.microposts.build
    end
    ##boardとの関連付け##
  end

  def new
    @book = Book.new
  end

  def create
    title = book_params[:title]
    @book = Book.find_by(title: title)

    if @book.blank?
      @book = Book.new(book_params)
    end

    if @book.save
      if @book.read_by?(current_user)
        flash.now[:info] = "「"+ title + "」は既に本棚に追加されています。"
        render new_book_path
      else
        @read = Read.new(user_id: current_user.id, book_id: @book.id)
        @read.save
        flash[:success] = "「"+ title + "」を本棚に追加しました。"
        redirect_to @book
      end
    else
      render new_book_path
    end
  end

  def destroy
    @user = current_user
    book.destroy
    flash[:success] = "Book deleted"
    redirect_to @user
  end

  private

    def book_params
      params.require(:book).permit(:title, :image)
    end
end
