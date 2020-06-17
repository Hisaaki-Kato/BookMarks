require 'rails_helper'

RSpec.describe BoardsController, type: :controller do
  describe "#create" do
    before do
      @user = create(:user)
      @book = create(:book)
    end
    #許可されたユーザーとして
    context "as an authorized user" do
      #ボードを追加できること
      it "adds a board" do
        log_in_as(@user)
        board_params = attributes_for(:board,
                                      user_id: @user.id,
                                      book_id: @book.id)
        expect {
          post :create, params: { board: board_params }
        }.to change(@user.boards, :count).by(1)
      end
    end

    #ゲストユーザーとして
    context "as an guest user" do
      #ログインurlにリダイレクトすること
      it "redirects to the login_url" do
        board_params = attributes_for(:board,
                                      user_id: @user.id,
                                      book_id: @book.id)
        post :create, params: { board: board_params }
        expect(response).to redirect_to login_url
      end
    end
  end
  
  describe "#edit" do
    before do
      @board = create(:board)
    end

    #許可されたユーザーとして
    context "as an authorized user" do
      #正常にレスポンスを返すこと
      it "responds successfully" do
        log_in_as(@board.user)
        get :edit, params: { id: @board.id }
        expect(response).to be_successful
      end
    end

    #ゲストユーザーとして
    context "as a guest user" do
      #ログインurlにリダイレクトすること
      it "redirects to the login_url" do
        get :edit, params: { id: @board.id }
        expect(response).to redirect_to login_url
      end
    end
  end

  describe "#update" do
    before do
      @board = create(:board)
    end
    #許可されたユーザーとして
    context "as an authorized user" do
      #ボードを更新できること
      it "updates the board" do
        log_in_as(@board.user)
        board_params = attributes_for(:board,
                                      title: "new title",
                                      user_id: @board.user.id,
                                      book_id: @board.book.id)
        patch :update, params: { id: @board.id, board: board_params }
        expect(@board.reload.title).to eq "new title"
      end
    end

    #許可されていないユーザーとして
    context "as an unauthorized user" do
      before do
        @other_user = create(:user, email: "other@example.com")
        log_in_as(@other_user)
      end
      #ボードを更新できないこと
      it "does not update the board" do
        board_params = attributes_for(:board,
                                      title: "new title",
                                      user_id: @board.user.id,
                                      book_id: @board.book.id)
        patch :update, params: { id: @board.id, board: board_params }
        expect(@board.reload.title).to eq "testboard"
      end

      #root_urlにリダイレクトすること
      it "redirects to the root_url" do
        board_params = attributes_for(:board,
                                      user_id: @board.user.id,
                                      book_id: @board.book.id)
        patch :update, params: { id: @board.id, board: board_params }
        expect(response).to redirect_to root_url
      end
    end

    #ゲストユーザーとして
    context "as a guest user" do
      #root_urlにリダイレクトすること
      it "does not update the board" do
        board_params = attributes_for(:board,
                                      user_id: @board.user.id,
                                      book_id: @board.book.id)
        patch :update, params: { id: @board.id, board: board_params }
        expect(response).to redirect_to login_url
      end
    end
  end

  describe "#destroy" do
    before do
      @board = create(:board)
    end
    #許可されたユーザーとして
    context "as an authorized user" do
      #ボードを削除できること
      it "deletes the board" do
        log_in_as(@board.user)
        expect{
          delete :destroy, params: { id: @board.id }
        }.to change(@board.user.boards, :count).by(-1)
      end
    end

    #許可されていないユーザーとして
    context "as an unauthorized user" do
      before do
        @other_user = create(:user, email: "other@example.com")
        log_in_as(@other_user)
      end
      #ボードを削除できないこと
      it "does not delete the board" do
        expect{
          delete :destroy, params: { id: @board.id }
        }.to_not change(@board.user.boards, :count)
      end

      #root_urlにリダイレクトすること
      it "redirects to the root_url" do
        delete :destroy, params: { id: @board.id }
        expect(response).to redirect_to root_url
      end
    end

    #ゲストユーザーとして
    context "as a guest user" do
      #ボードを削除できないこと
      it "does not delete the board" do
        expect{
          delete :destroy, params: { id: @board.id }
        }.to_not change(@board.user.boards, :count)
      end

      #login_urlにリダイレクトすること
      it "redirects to the root_url" do
        delete :destroy, params: { id: @board.id }
        expect(response).to redirect_to login_url
      end
    end
  end
end
