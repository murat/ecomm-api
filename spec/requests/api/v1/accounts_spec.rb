# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Api::V1::Accounts', type: :request do
  let!(:token) { FactoryBot.create(:oauth_token).token }

  describe 'GET /api/v1/account' do
    it 'returns unauthorized if header does not exist.' do
      get api_v1_account_path
      expect(response).to have_http_status(401)
    end

    it 'works!' do
      get api_v1_account_path, params: {}, headers: { authorization: "Bearer #{token}" }
      expect(response).to have_http_status(200)
    end
  end
end
