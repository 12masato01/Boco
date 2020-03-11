# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TopController, type: :request do
  describe 'トップページ' do
    it '正常なレスポンスを返す' do
      get root_path
      expect(response).to have_http_status(:success)
    end
  end
end
