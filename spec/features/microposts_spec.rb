# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Microposts', type: :feature do
  # 許可されたユーザーとして
  context 'as an authorized user' do
    before do
      @user = create(:user)
      @book = create(:book)
      log_in_as(@user)
    end
    # ユーザーは新しいポストを作成する
    scenario 'user creates a new micropost' do
      expect do
        visit book_path(@book.id)
        fill_in 'micropost[quoted_text]',	with: 'test post'
        fill_in 'micropost[content]',	with: 'test content'
        click_button 'メモを投稿する'

        expect(page).to have_content 'test post'
        expect(page).to have_content 'test content'
      end.to change(@user.microposts, :count).by(1)
    end

    # 正しくない内容ではポストは作成されない
    scenario 'user does not create a post with invalid content' do
      expect do
        visit book_path(@book.id)
        fill_in 'micropost[quoted_text]',	with: nil
        fill_in 'micropost[content]',	with: 'test content'
        click_button 'メモを投稿する'

        expect(page).to have_content '正しい内容を入力してください'
        expect(page).to_not have_content 'test content'
      end.to_not change(@user.microposts, :count)
    end

    # ユーザーは自分のポストを削除する
    scenario 'user deletes own micropost' do
      other_user = create(:tester)
      other_micropost = create(:micropost,
                               user_id: other_user.id,
                               book_id: @book.id)
      my_micropost = create(:micropost,
                            user_id: @user.id,
                            book_id: @book.id)
      expect do
        visit book_path(@book.id)
        within "#micropost-#{my_micropost.id}" do
          click_link 'メモを削除する'
        end
        expect(page).to have_content '学びメモを削除しました。'
        expect(page).to_not have_selector "li#micropost-#{my_micropost.id}"
        expect(page).to have_selector "li#micropost-#{other_micropost.id}"
      end.to change(@user.microposts, :count).by(-1)
    end
  end

  # ゲストユーザーとして
  context 'as a guest user' do
    before do
      @book = create(:book)
    end

    # ポストの投稿フォームが表示されない
    scenario 'user can not find the micropost form' do
      visit book_path(@book.id)
      expect(page).to_not have_content 'メモを投稿する'
      expect(page).to have_content 'みんなの学びメモ'
    end
  end
end
