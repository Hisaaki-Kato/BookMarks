require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "#index" do
    #許可されたユーザーとして
    context "as an authorized user" do
      #正常にレスポンスを返すこと
      it "responds successfully" do
        user = create(:user)
        log_in_as(user)
        get :index
        expect(response).to be_successful
      end
    end

    #ゲストユーザーとして
    context "as an guest user" do
      #ログインurlにリダイレクトすること
      it "redirects to the login_url" do
        get :index
        expect(response).to redirect_to login_url
      end
    end
  end

  describe "#show" do
    #正常にレスポンスを返すこと
    it "responds successfully" do
      user = create(:user)
      get :show, params: { id: user.id }
      expect(response).to be_successful
    end
  end
  
  describe "#new" do
    #正常にレスポンスを返すこと
    it "responds successfully" do
      get :new
      expect(response).to be_successful
    end
  end
  
  describe "#create" do
    it "adds a user" do
      user_params = attributes_for(:user)
      expect {
        post :create, params: { user: user_params }
      }.to change(User, :count).by(1)
    end
  end
  
  describe "#edit" do
    before do
      @user = create(:user)
    end

    #許可されたユーザーとして
    context "as an authorized user" do
      #正常にレスポンスを返すこと
      it "responds successfully" do
        log_in_as(@user)
        get :edit, params: { id: @user.id }
        expect(response).to be_successful
      end
    end

    #許可ｓれていないユーザーとして
    context "as an authorized user" do
      #root_urlにリダイレクトすること
      it "redirects to the root_url" do
        other_user = create(:user, email: "other@example.com")
        log_in_as(other_user)
        get :edit, params: { id: @user.id }
        expect(response).to redirect_to root_url
      end
    end

    #ゲストユーザーとして
    context "as a guest user" do
      #ログインurlにリダイレクトすること
      it "redirects to the login_url" do
        get :edit, params: { id: @user.id }
        expect(response).to redirect_to login_url
      end
    end
  end

  describe "#update" do
    before do
      @user = create(:user)
    end
    #許可されたユーザーとして
    context "as an authorized user" do
      #ユーザーを更新できること
      it "updates the user" do
        log_in_as(@user)
        user_params = attributes_for(:user, name: "new name")
        patch :update, params: { id: @user.id, user: user_params }
        expect(@user.reload.name).to eq "new name"
      end
    end

    #許可されていないユーザーとして
    context "as an unauthorized user" do
      before do
        @other_user = create(:user, email: "other@example.com")
        log_in_as(@other_user)
      end
      #ユーザーを更新できないこと
      it "does not update the user" do
        user_params = attributes_for(:user, name: "new name")
        patch :update, params: { id: @user.id, user: user_params }
        expect(@user.reload.name).to eq "Hisaaki"
      end

      #root_urlにリダイレクトすること
      it "redirects to the root_url" do
        user_params = attributes_for(:user)
        patch :update, params: { id: @user.id }
        expect(response).to redirect_to root_url
      end
    end

    #ゲストユーザーとして
    context "as a guest user" do
      #root_urlにリダイレクトすること
      it "does not update the user" do
        user_params = attributes_for(:user)
        patch :update, params: { id: @user.id }
        expect(response).to redirect_to login_url
      end
    end
  end

  describe "#destroy" do
    before do
      @user = create(:user)
    end
    #管理者ユーザーとして
    context "as an admin user" do
      #ボードを削除できること
      it "deletes the user" do
        admin = create(:admin)
        log_in_as(admin)
        expect{
          delete :destroy, params: { id: @user.id }
        }.to change(User, :count).by(-1)
      end
    end

    #許可されていないユーザーとして
    context "as an unauthorized user" do
      before do
        log_in_as(@user)
      end
      #ユーザーを削除できないこと
      it "does not delete the user" do
        expect{
          delete :destroy, params: { id: @user.id }
        }.to_not change(User, :count)
      end

      #root_urlにリダイレクトすること
      it "redirects to the root_url" do
        delete :destroy, params: { id: @user.id }
        expect(response).to redirect_to root_url
      end
    end

    #ゲストユーザーとして
    context "as a guest user" do
      #ボードを削除できないこと
      it "does not delete the user" do
        expect{
          delete :destroy, params: { id: @user.id }
        }.to_not change(User, :count)
      end

      #login_urlにリダイレクトすること
      it "redirects to the login_url" do
        delete :destroy, params: { id: @user.id }
        expect(response).to redirect_to login_url
      end
    end
  end
end
