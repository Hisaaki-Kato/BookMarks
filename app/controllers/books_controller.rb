class BooksController < ApplicationController
  include GoogleBooksApi #app/lib

  require 'net/http'
  require 'uri'
  require 'json'
  require 'httparty'

  before_action :logged_in_user, only: [:new, :create, :destroy]

  def show
    @book = Book.find(params[:id])
    @microposts = @book.microposts.includes(:user)
    if logged_in?
      #新規作成用
      @board = current_user.boards.build
      @micropost = current_user.microposts.build

      #ログイン時には、自他を分ける
      @my_board = current_user.boards.find_by(book_id: @book.id)
      @my_microposts = current_user.microposts.where(book_id: @book.id)

      @other_microposts = @microposts.where.not(user_id: current_user.id)
    end
  end

  def new
    if params[:title].blank?    
      #本を選択前の処理
      if params[:keyword].present?
        @books = GoogleBooksApi.get_results(params[:keyword])
        if @books.nil?
          #検索結果がない場合
          @keyword = params[:keyword]
          @book = Book.new
        end
      end
    else
      #本を選択後の処理
      @image = params[:image]
      if @image.nil?
        #画像はない場合があるため、置き換え
        @image = "no-image.png"
      end

      @book = Book.find_by(title: params[:title], image: @image)
      unless @book.nil?
        #本がDBに既に存在する場合
        redirect_to @book
      else
        #本がDBに存在しない場合
        @book = Book.new
        @title = params[:title]
      end
    end
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      @read = Read.new(user_id: current_user.id, book_id: @book.id)
      @read.save
      flash[:success] = "本棚に追加しました。"
      redirect_to @book
    else
      flash.now[:danger] = "追加できませんでした。"
      render new_book_path
    end
  end

  def destroy
    @user = current_user
    book.destroy
    flash[:success] = "本棚から削除しました。"
    redirect_to @user
  end

  private

    def book_params
      params.require(:book).permit(:keyword, :title, :image)
    end
end
