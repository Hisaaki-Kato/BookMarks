# frozen_string_literal: true

class MicropostsController < ApplicationController
  include GoogleBooksApi # app/lib
  include RecommendBooksApi # app/lib

  require 'net/http'
  require 'uri'
  require 'json'
  require 'httparty'

  before_action :logged_in_user, only: %i[create destroy]
  before_action :correct_user,   only: :destroy

  def index
    @microposts = Micropost.includes(:user).page(params[:page]).per(20)
    @popular_books = Book.popular

    ###
    documents = {'documents' => [
      'Pythonは強力で、学びやすいプログラミング言語です。',
      '効率的な高レベルデータ構造と、シンプルで効果的なオブジェクト指向プログラミング機構を備えています。',
      'Pythonは、洗練された文法・動的なデータ型付け・インタープリタであることなどから、スクリプティングや高速アプリケーション開発(Rapid Application Development: RAD)に理想的なプログラミング言語となっています。',
      'Python (https://www.python.org) は、Pythonインタープリタと標準ライブラリのソースコードと、主要プラットフォームごとにコンパイル済みのバイナリファイルを無料で配布しています。',
      'また、Pythonには、無料のサードパーティモジュールやプログラム、ツール、ドキュメントなども紹介しています。'
    ]}
    response = RecommendBooksApi.post_request(documents)
    @words = response['important_words']
  end

  def show
    @micropost = Micropost.find(params[:id])
    @comments = @micropost.comments.includes(:user)
    @comment = @micropost.comments.build if logged_in?
  end

  def create
    @user = current_user
    @book = Book.find(micropost_params[:book_id])
    @micropost = current_user.microposts.build(micropost_params)
    flash[:danger] = '正しい内容を入力してください' unless @micropost.save
    redirect_to @book
  end

  def destroy
    @micropost.destroy
    flash[:success] = '学びメモを削除しました。'
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
