# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Books', type: :feature do
  describe '#show' do
    before do
      @book = create(:book)
    end
    # 許可されたユーザーとして
    context 'as an authorized user' do
      before do
        @user = create(:user)
        log_in_as(@user)
      end

      # 3つのタブが存在する
      scenario 'finds three tabs' do
        visit book_path(@book.id)
        expect(page).to have_content 'My学びメモ'
        expect(page).to have_content 'My学びボード'
        expect(page).to have_content '他の人のメモ'
      end
    end
  end

  describe '#new, #create' do
    # 許可されたユーザーとして
    context 'as authorized user' do
      before do
        @user = create(:user)
        log_in_as(@user)
        visit root_path
        click_link '書籍を探す'
      end

      # 検索結果が存在する場合
      context 'search results exists' do
        # ユーザーは本を検索し、本棚に登録する
        scenario 'user search a book and registers the book to the shelf' do
          expect do
            within 'div.books-new-form' do
              fill_in 'keyword', with: 'ruby'
              click_button '検索'
            end
            expect(page).to have_selector('div.col-md-3', count: 10)
            within first('div.col-md-3') do
              find('a').click
            end
            expect(page).to have_content '選択した本'
            click_button '本棚に追加する'
          end.to change(Book, :count).by(1)
        end
      end

      # 検索結果が存在しない場合
      context 'search result does not exist' do
        # ユーザーは独自の本を本棚に登録する
        scenario 'user registers the original book to the shelf' do
          expect do
            within 'div.books-new-form' do
              fill_in 'keyword', with: '-------------------------'
              click_button '検索'
            end
            expect(page).to have_content '書籍が見つかりません!'
            click_button '本棚に追加する'
          end.to change(Book, :count).by(1)
        end
      end
    end
  end

  describe '#destroy' do
    before do
      @book = create(:book)
    end
    # 管理者ユーザーとして
    context 'as an admin user' do
      before do
        @admin = create(:admin)
        log_in_as(@admin)
      end

      # ユーザーは本を削除する
      scenario 'user deletes the book from db' do
        expect do
          visit book_path(@book.id)
          expect(page).to have_link 'delete'
          click_link 'delete'
        end.to change(Book, :count).by(-1)
      end
    end
  end
end
