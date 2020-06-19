# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe '#create' do
    before do
      @user = create(:tester)
      @micropost = create(:micropost)
    end
    # 許可されたユーザーとして
    context 'as an authorized user' do
      # コメントを追加できること
      it 'adds a comment' do
        log_in_as(@user)
        comment_params = attributes_for(:comment,
                                        user_id: @user.id,
                                        micropost_id: @micropost.id)
        expect do
          post :create, params: { micropost_id: @micropost.id, comment: comment_params }
        end.to change(@user.comments, :count).by(1)
      end
    end

    # #ゲストユーザーとして
    context 'as an guest user' do
      # コメントを追加できないこと
      it 'does not add a comment' do
        comment_params = attributes_for(:comment,
                                        user_id: @user.id,
                                        micropost_id: @micropost.id)
        expect do
          post :create, params: { micropost_id: @micropost.id, comment: comment_params }
        end.to_not change(Comment, :count)
      end

      # ログインurlにリダイレクトすること
      it 'redirects to the login_url' do
        comment_params = attributes_for(:comment,
                                        user_id: @user.id,
                                        micropost_id: @micropost.id)
        post :create, params: { micropost_id: @micropost.id, comment: comment_params }
        expect(response).to redirect_to login_url
      end
    end
  end

  describe '#destroy' do
    # 許可されたユーザーとして
    context 'as an authorized user' do
      # コメントを削除できること
      it 'deletes the comment' do
        comment = create(:comment)
        log_in_as(comment.user)
        expect do
          delete :destroy, params: { micropost_id: comment.micropost.id,
                                     comment_id: comment.id }
        end.to change(Comment, :count).by(-1)
      end
    end

    # 許可されていないユーザーとして
    context 'as an unauthorized user' do
      before do
        @comment = create(:comment)
        @other_user = create(:user, email: 'other@example.com')
        log_in_as(@other_user)
      end
      # コメントを削除できないこと
      it 'does not delete the comment' do
        expect do
          delete :destroy, params: { micropost_id: @comment.micropost.id,
                                     comment_id: @comment.id }
        end.to_not change(Comment, :count)
      end

      # root_urlにリダイレクトすること
      it 'redirects to the root_url' do
        delete :destroy, params: { micropost_id: @comment.micropost.id,
                                   comment_id: @comment.id }
        expect(response).to redirect_to root_url
      end
    end

    # ゲストユーザーとして
    context 'as a guest user' do
      before do
        @comment = create(:comment)
      end
      # コメントを削除できないこと
      it 'does not delete the comment' do
        expect do
          delete :destroy, params: { micropost_id: @comment.micropost.id,
                                     comment_id: @comment.id }
        end.to_not change(Comment, :count)
      end

      # login_urlにリダイレクトすること
      it 'redirects to the login_url' do
        delete :destroy, params: { micropost_id: @comment.micropost.id,
                                   comment_id: @comment.id }
        expect(response).to redirect_to login_url
      end
    end
  end
end
