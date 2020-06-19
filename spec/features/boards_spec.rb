# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Boards', type: :feature do
  # 許可されたユーザーとして
  context 'as an authorized user' do
    before do
      @user = create(:user)
      @book = create(:book)
      log_in_as(@user)
    end
    # ユーザーは新しいボードを作成する
    scenario 'user creates a new board' do
      expect do
        visit book_path(@book.id)
        fill_in 'board[title]',	with: 'test board'
        fill_in 'board[content]',	with: 'test content'
        click_button '学びボードを作成する'

        expect(page).to have_content 'test board'
        expect(page).to have_content 'test content'
      end.to change(@user.boards, :count).by(1)
    end

    # 正しくない内容ではボードは作成されない
    scenario 'user does not create a board with invalid content' do
      expect do
        visit book_path(@book.id)
        fill_in 'board[title]',	with: nil
        fill_in 'board[content]',	with: 'test content'
        click_button '学びボードを作成する'

        expect(page).to have_content '正しい内容を入力してください'
        expect(page).to_not have_content 'test content'
      end.to_not change(@user.boards, :count)
    end

    # 自分のボードが既に作成されている場合
    context 'when the board has already been created' do
      before do
        @board = create(:board, user_id: @user.id, book_id: @book.id)
      end
      # ユーザーはボードを追加できない
      scenario 'user can not add a board' do
        expect do
          visit book_path(@book.id)
          expect(page).to have_content @board.content
          expect(page).to_not have_content '学びボードを作成する'
        end.to_not change(@user.boards, :count)
      end

      # ユーザーはボードを削除する
      scenario 'user deletes own board' do
        expect do
          visit book_path(@book.id)
          click_link '削除'
          expect(page).to have_content '学びボードを削除しました。'
          expect(page).to_not have_content @board.content
        end.to change(@user.boards, :count).by(-1)
      end

      # ユーザーはボードを編集する
      scenario 'user updates own board' do
        visit book_path(@book.id)
        click_link '編集'
        expect(page).to have_current_path edit_board_path(@board.id)

        fill_in 'board[content]',	with: 'updated content'
        click_button '変更を保存する'

        expect(page).to have_content '学びボードが更新されました。'
        expect(page).to have_content 'updated content'
      end
    end
  end

  # ゲストユーザーとして
  context 'as a guest user' do
    before do
      @book = create(:book)
    end

    # ボードの投稿フォームが表示されない
    scenario 'user can not find the board form' do
      visit book_path(@book.id)
      expect(page).to_not have_content '学びボードを作成する'
    end
  end
end
