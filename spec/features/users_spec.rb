# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Users', type: :feature do
  before do
    @user = create(:user)
    @other_user = create(:tester)
  end

  describe '#show' do
    # 自分のユーザーページではMyページが表示される
    scenario 'my page is displayed on own user/show page' do
      log_in_as(@user)
      visit user_path(@user.id)
      expect(page).to have_content 'プロフィール'
      expect(page).to have_content 'タイムライン'
    end

    # 他人のユーザーページではマイクロポストのみが表示される
    scenario "only microposts are displayed on other user's page" do
      visit user_path(@other_user.id)
      expect(page).to_not have_content 'プロフィール'
      expect(page).to_not have_content 'タイムライン'
      expect(page).to have_content '学びメモ'
    end
  end

  describe '#edit, #update' do
    # ユーザーはプロフィールを編集する
    scenario 'user edit own profile' do
      log_in_as(@user)
      visit user_path(@user.id)
      click_link 'プロフィールを編集する'

      expect(page).to have_current_path edit_user_path(@user.id)
      fill_in 'user[name]',	with: 'updated name'
      attach_file 'user[picture]', 'public/no-image.png'
      click_button '変更を保存する'

      expect(page).to have_content 'プロフィールが更新されました。'
      within '.user-info' do
        expect(page).to have_content 'updated name'
        expect(page.find('.user_picture')['src']).to have_content 'no-image.png'
      end
    end
  end

  describe '#new, #create' do
    # ユーザーを新規登録する
    scenario 'newly register the user' do
      visit root_path
      click_link '新規登録'

      expect do
        fill_in 'user[name]', with: 'new user'
        fill_in 'user[email]', with: 'new@example.com'
        fill_in 'user[password]', with: 'new_password'
        fill_in 'user[password_confirmation]', with: 'new_password'
        click_button '新規登録する'

        expect(page).to have_content 'ようこそ!BookMarksへ!'
      end.to change(User, :count).by(1)
    end
  end

  describe '#destroy' do
    # 管理者ユーザーはユーザーを削除する
    scenario 'admin user destroy user' do
      admin = create(:admin)
      log_in_as(admin)
      visit root_path

      expect do
        click_link '他のユーザー'
        click_link 'delete', match: :first
      end.to change(User, :count).by(-1)
    end
  end
end
