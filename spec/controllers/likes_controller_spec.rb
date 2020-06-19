# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  describe '#create' do
    before do
      @user = create(:tester)
      @micropost = create(:micropost)
    end
    # ポストの投稿者でないユーザーとして
    context 'as a non-owner user ' do
      # いいねを追加できること
      it 'adds a like' do
        log_in_as(@user)
        expect do
          post :create, params: { micropost_id: @micropost.id }, xhr: true
        end.to change(Like, :count).by(1)
      end
    end

    # ポストの投稿者であるユーザーとして
    context 'as a owner user ' do
      before do
        log_in_as(@micropost.user)
      end
      # いいねを追加できないこと
      it 'does not add a like' do
        expect do
          post :create, params: { micropost_id: @micropost.id }, xhr: true
        end.to_not change(Like, :count)
      end

      # root_urlにリダイレクトすること
      it 'redirects to the root_url' do
        post :create, params: { micropost_id: @micropost.id }, xhr: true
        expect(response).to redirect_to root_url
      end
    end

    # #ゲストユーザーとして
    context 'as an guest user' do
      # いいねを追加できないこと
      it 'does not add a like' do
        expect do
          post :create, params: { micropost_id: @micropost.id }, xhr: true
        end.to_not change(Like, :count)
      end

      # ログインurlにリダイレクトすること
      it 'redirects to the login_url' do
        post :create, params: { micropost_id: @micropost.id }, xhr: true
        expect(response).to redirect_to login_url
      end
    end
  end

  describe '#destroy' do
    before do
      @user = create(:tester)
      @micropost = create(:micropost)
      @like = Like.create(user_id: @user.id,
                          micropost_id: @micropost.id)
    end
    # 許可されたユーザーとして
    context 'as an authorized user' do
      # いいねを削除できること
      it 'deletes the like' do
        log_in_as(@user)
        expect do
          delete :destroy, params: { micropost_id: @micropost.id }, xhr: true
        end.to change(Like, :count).by(-1)
      end
    end

    # 許可されていないユーザーとして
    context 'as an unauthorized user' do
      before do
        @other_user = create(:user, email: 'other@example.com')
        log_in_as(@other_user)
      end
      # いいねを削除できないこと
      it 'does not delete the like' do
        expect do
          delete :destroy, params: { micropost_id: @micropost.id }, xhr: true
        end.to_not change(Like, :count)
      end

      # root_urlにリダイレクトすること
      it 'redirects to the root_url' do
        delete :destroy, params: { micropost_id: @micropost.id }, xhr: true
        expect(response).to redirect_to root_url
      end
    end

    # ゲストユーザーとして
    context 'as a guest user' do
      # コメントを削除できないこと
      it 'does not delete the comment' do
        expect do
          delete :destroy, params: { micropost_id: @micropost.id }, xhr: true
        end.to_not change(Like, :count)
      end

      # login_urlにリダイレクトすること
      it 'redirects to the login_url' do
        delete :destroy, params: { micropost_id: @micropost.id }, xhr: true
        expect(response).to redirect_to login_url
      end
    end
  end
end
