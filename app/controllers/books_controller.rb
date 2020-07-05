# frozen_string_literal: true

class BooksController < ApplicationController
  include GoogleBooksApi # app/lib

  require 'net/http'
  require 'uri'
  require 'json'
  require 'httparty'

  before_action :logged_in_user, only: %i[new create destroy]
  before_action :admin_user,     only: :destroy

  def show
    @book = Book.find(params[:id])
    @microposts = @book.microposts.includes(:user)
    if logged_in?
      # 新規作成用
      @board = current_user.boards.build
      @micropost = current_user.microposts.build

      # ログイン時には、自他を分ける
      @my_board = current_user.boards.find_by(book_id: @book.id)
      @my_microposts = current_user.microposts.where(book_id: @book.id)

      @other_microposts = @microposts.where.not(user_id: current_user.id)
    end
  end

  def new
    if params[:title].blank?
      # 本を選択前の処理
      if params[:keyword].present?
        @books = GoogleBooksApi.get_results(params[:keyword])
        if @books.nil?
          # 検索結果がない場合
          @keyword = params[:keyword]
          @book = Book.new
        end
      end
    else
      # 本を選択後の処理
      @title = params[:title]
      @image = params[:image]
      @book = Book.find_by(title: @title, image: @image)
      if @book.nil?
        # 本がDBに存在しない場合
        @book = Book.new
      else
        # 本がDBに既に存在する場合
        redirect_to @book
      end
    end
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      # current_userの本棚にも追加する
      Read.create(user_id: current_user.id, book_id: @book.id)
      flash[:success] = '本棚に追加しました。'
      redirect_to @book
    else
      flash.now[:danger] = '追加できませんでした。'
      render new_book_path
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    flash[:success] = '本を削除しました。'
    redirect_to root_path
  end

  private

  def book_params
    params.require(:book).permit(:keyword, :title, :image)
  end
end
