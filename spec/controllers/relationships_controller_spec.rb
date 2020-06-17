require 'rails_helper'

RSpec.describe RelationshipsController, type: :controller do
  describe "#create" do
    before do
      @user = create(:tester)
      @other_user = create(:user)
    end
    #許可されたユーザーとして
    context "as an authorized user" do
      #フォローを追加できること
      it "adds a relationship" do
        log_in_as(@user)
        expect {
          post :create, params: { followed_id: @other_user.id }, xhr: true
        }.to change(Relationship, :count).by(1)
      end
    end

    # #ゲストユーザーとして
    context "as an guest user" do
      #フォローを追加できないこと
      it "does not add a relationship" do
        expect {
          post :create, params: { followed_id: @other_user.id }, xhr: true
        }.to_not change(Relationship, :count)
      end

      #ログインurlにリダイレクトすること
      it "redirects to the login_url" do
        post :create, params: { followed_id: @other_user.id }, xhr: true
        expect(response).to redirect_to login_url
      end
    end
  end
  
  describe "#destroy" do
    before do
      @follower_user = create(:tester)
      @followed_user = create(:user)
      @relationship = Relationship.create(follower_id: @follower_user.id,
                                          followed_id: @followed_user.id)
    end
    #許可されたユーザーとして
    context "as an authorized user" do
      #フォローを削除できること
      it "deletes the relationship" do
        log_in_as(@follower_user)
        expect {
          delete :destroy, params: { id: @relationship.id }, xhr: true
        }.to change(Relationship, :count).by(-1)
      end
    end

    #許可されていないユーザーとして
    context "as an unauthorized user" do
      before do
        @other_user = create(:user, email: "other@example.com")
        log_in_as(@other_user)
      end
      #フォローを削除できないこと
      it "does not delete the relationship" do
        expect {
          delete :destroy, params: { id: @relationship.id }, xhr: true
        }.to_not change(Relationship, :count)
      end

      #root_urlにリダイレクトすること
      it "redirects to the root_url" do
        delete :destroy, params: { id: @relationship.id }, xhr: true
        expect(response).to redirect_to root_url
      end
    end

    #ゲストユーザーとして
    context "as a guest user" do
      #フォローを削除できないこと
      it "does not delete the relationship" do
        expect {
          delete :destroy, params: { id: @relationship.id }, xhr: true
        }.to_not change(Relationship, :count)
      end

      #login_urlにリダイレクトすること
      it "redirects to the login_url" do
        delete :destroy, params: { id: @relationship.id }, xhr: true
        expect(response).to redirect_to login_url
      end
    end
  end
end
