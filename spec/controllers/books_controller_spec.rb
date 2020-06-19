# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  describe '#show' do
    # 正常にレスポンスを返すこと
    it 'responds successfully' do
      book = create(:book)
      get :show, params: { id: book.id }
      expect(response).to be_successful
    end
  end

  describe '#new' do
    # 許可されたユーザーとして
    context 'as an authorized user' do
      before do
        @user = create(:user)
        log_in_as(@user)
      end

      # 正常にレスポンスを返すこと
      it 'responds successfully' do
        get :new
        expect(response).to be_successful
      end

      # 本が選択されている場合
      context 'when a book is chosen' do
        # 本が既に登録されている場合
        context 'when the book exists in db' do
          before do
            @book = create(:book)
          end

          # 本のページにリダイレクトすること
          it 'redirects to the book_url' do
            get :new, params: { title: @book.title, image: @book.image }
            expect(response).to redirect_to @book
          end
        end
      end
    end

    # ゲストユーザーとして
    context 'as a guest user' do
      # ログインurlにリダイレクトすること
      it 'redirects to the login_url' do
        get :new
        expect(response).to redirect_to login_url
      end
    end
  end

  describe '#create' do
    # 許可されたユーザーとして
    context 'as an authorized user' do
      before do
        @user = create(:user)
        log_in_as(@user)
      end

      # 本が既に登録されている場合
      context 'when the book exists in db' do
        before do
          @book = create(:book)
        end
        # 本を登録できないこと
        it 'does not add a book' do
          book_params = attributes_for(:book)
          expect do
            post :create, params: { book: book_params }
          end.to_not change(Book, :count)
        end
      end

      # 本が登録されていない場合
      context 'when the book does not exist in db' do
        # 本を登録できること
        it 'adds a book' do
          book_params = attributes_for(:book)
          expect do
            post :create, params: { book: book_params }
          end.to change(Book, :count).by(1)
        end

        # 本棚にも追加されること
        it 'also adds a book to shelf' do
          book_params = attributes_for(:book)
          expect do
            post :create, params: { book: book_params }
          end.to change(Read, :count).by(1)
        end
      end
    end

    # ゲストユーザーとして
    context 'as a guest user' do
      # ログインurlにリダイレクトすること
      it 'redirects to the login_url' do
        book_params = attributes_for(:book)
        post :create, params: { book: book_params }
        expect(response).to redirect_to login_url
      end
    end
  end

  describe '#destroy' do
    before do
      @book = create(:book)
    end
    # 管理者ユーザーとして
    context 'as an admin user' do
      # 本を削除できること
      it 'deletes the book' do
        admin = create(:admin)
        log_in_as(admin)
        expect do
          delete :destroy, params: { id: @book.id }
        end.to change(Book, :count).by(-1)
      end
    end

    # 許可されていないユーザーとして
    context 'as an unauthorized user' do
      before do
        user = create(:user)
        log_in_as(user)
      end
      # 本を削除できないこと
      it 'does not delete the book' do
        expect do
          delete :destroy, params: { id: @book.id }
        end.to_not change(Book, :count)
      end

      # root_urlにリダイレクトすること
      it 'redirects to the root_url' do
        delete :destroy, params: { id: @book.id }
        expect(response).to redirect_to root_url
      end
    end

    # ゲストユーザーとして
    context 'as a guest user' do
      # 本を削除できないこと
      it 'does not delete the user' do
        expect do
          delete :destroy, params: { id: @book.id }
        end.to_not change(Book, :count)
      end

      # login_urlにリダイレクトすること
      it 'redirects to the login_url' do
        delete :destroy, params: { id: @book.id }
        expect(response).to redirect_to login_url
      end
    end
  end
end
