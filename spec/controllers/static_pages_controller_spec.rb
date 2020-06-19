# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe '#about' do
    # 正常にレスポンスを返すこと
    it 'responds successfully' do
      get :about
      expect(response).to be_successful
    end
  end

  describe '#contact' do
    # 正常にレスポンスを返すこと
    it 'responds successfully' do
      get :contact
      expect(response).to be_successful
    end
  end
end
