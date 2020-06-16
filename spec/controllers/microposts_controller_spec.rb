require 'rails_helper'

RSpec.describe MicropostsController, type: :controller do
  describe "#index" do
    #正常にレスポンスを返すこと
    it "responds successfully" do
      get :index
      expect(response).to be_successful
    end
  end
  
  describe "#show" do
    #正常にレスポンスを返すこと
    it "responds successfully" do
      micropost = create(:micropost)
      get :show, params: { id: micropost.id }
      expect(response).to be_successful
    end
  end
  
  describe "#create" do
    before do
      @user = create(:user)
      @book = create(:book)
    end
    #許可されたユーザーとして
    context "as an authorized user" do
      #ポストを追加できること
      it "adds a micropost" do
        log_in_as(@user)
        micropost_params = attributes_for(:micropost,
                                          user_id: @user.id,
                                          book_id: @book.id)
        expect {
          post :create, params: { micropost: micropost_params }
        }.to change(@user.microposts, :count).by(1)
      end
    end

    # #ゲストユーザーとして
    context "as an guest user" do
      #ポストを追加できないこと
      it "does not add a micropost" do
        micropost_params = attributes_for(:micropost,
                                          user_id: @user.id,
                                          book_id: @book.id)
        expect {
          post :create, params: { micropost: micropost_params }
        }.to_not change(@user.microposts, :count)
      end

      #ログインurlにリダイレクトすること
      it "redirects to the login_url" do
        micropost_params = attributes_for(:micropost,
                                          user_id: @user.id,
                                          book_id: @book.id)
        post :create, params: { micropost: micropost_params }
        expect(response).to redirect_to login_url
      end
    end
  end
  
  describe "#destroy" do
    before do
      @other_user = create(:user, email: "other@example.com")
      @micropost = create(:micropost)
    end
    #許可されたユーザーとして
    context "as an authorized user" do
      #ボードを削除できること
      it "deletes the micropost" do
        log_in_as(@micropost.user)
        expect{
          delete :destroy, params: { id: @micropost.id }
        }.to change(@micropost.user.microposts, :count).by(-1)
      end
    end

    #許可されていないユーザーとして
    context "as an unauthorized user" do
      before do
        log_in_as(@other_user)
      end
      #ボードを削除できないこと
      it "does not delete the micropost" do
        expect{
          delete :destroy, params: { id: @micropost.id }
        }.to_not change(@micropost.user.microposts, :count)
      end

      #root_urlにリダイレクトすること
      it "redirects to the root_url" do
        delete :destroy, params: { id: @micropost.id }
        expect(response).to redirect_to root_url
      end
    end

    #ゲストユーザーとして
    context "as a guest user" do
      #ボードを削除できないこと
      it "does not delete the micropost" do
        expect{
          delete :destroy, params: { id: @micropost.id }
        }.to_not change(@micropost.user.microposts, :count)
      end

      #login_urlにリダイレクトすること
      it "redirects to the root_url" do
        delete :destroy, params: { id: @micropost.id }
        expect(response).to redirect_to login_url
      end
    end
  end
  
end
