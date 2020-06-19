# frozen_string_literal: true

class ReadsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: :destroy

  def create
    read = current_user.reads.build(book_id: params[:book_id])
    read.save

    redirect_back(fallback_location: books_path)
  end

  def destroy
    read = Read.find_by(book_id: params[:book_id], user_id: current_user.id)
    read.destroy

    redirect_back(fallback_location: books_path)
  end

  private

  def correct_user
    read = Read.where(book_id: params[:book_id], user_id: current_user.id)
    redirect_to root_url if read.blank?
  end
end
