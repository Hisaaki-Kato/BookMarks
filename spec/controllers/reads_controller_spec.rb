require 'rails_helper'

RSpec.describe ReadsController, type: :controller do
  describe "#create" do
    before do
      @user = create(:user)
      @book = create(:book)
    end
    #許可されたユーザーとして
    context "as an authorized user" do
      #本棚に追加できること
      it "adds a book to the shelf" do
        log_in_as(@user)
        expect {
          post :create, params: { book_id: @book.id }
        }.to change(Read, :count).by(1)
      end
    end

    #ゲストユーザーとして
    context "as an guest user" do
      #フォローを追加できないこと
      it "does not add a book to the shelf" do
        expect {
          post :create, params: { book_id: @book.id }
        }.to_not change(Read, :count)
      end

      #ログインurlにリダイレクトすること
      it "redirects to the login_url" do
        post :create, params: { book_id: @book.id }
        expect(response).to redirect_to login_url
      end
    end
  end
  
  describe "#destroy" do
    before do
      @user = create(:user)
      @book = create(:book)
      read = Read.create(user_id: @user.id,
                         book_id: @book.id)
    end
    #許可されたユーザーとして
    context "as an authorized user" do
      #本棚から削除できること
      it "deletes the book from the shelf" do
        log_in_as(@user)
        expect{
          delete :destroy, params: { book_id: @book.id }
        }.to change(Read, :count).by(-1)
      end
    end

    #許可されていないユーザーとして
    context "as an unauthorized user" do
      before do
        @other_user = create(:user, email: "other@example.com")
        log_in_as(@other_user)
      end
      #本棚から削除できないこと
      it "does not delete the book from the shelf" do
        expect{
          delete :destroy, params: { book_id: @book.id }
        }.to_not change(Read, :count)
      end

      #root_urlにリダイレクトすること
      it "redirects to the root_url" do
        delete :destroy, params: { book_id: @book.id }
        expect(response).to redirect_to root_url
      end
    end

    #ゲストユーザーとして
    context "as a guest user" do
      #本棚から削除できないこと
      it "does not delete the book from the shelf" do
        expect{
          delete :destroy, params: { book_id: @book.id }
        }.to_not change(Read, :count)
      end

      #login_urlにリダイレクトすること
      it "redirects to the login_url" do
        delete :destroy, params: { book_id: @book.id }
        expect(response).to redirect_to login_url
      end
    end
  end
end
