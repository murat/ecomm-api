# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Api::V1::Orders', type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:access) { FactoryBot.create(:access_token, resource_owner_id: user.id) }

  describe 'GET /orders' do
    it 'returns unauthorized if header does not exist.' do
      get api_v1_addresses_path
      expect(response).to have_http_status(401)
    end

    it 'works!' do
      get api_v1_addresses_path, params: {}, headers: { authorization: "Bearer #{access.token}" }
      expect(response).to have_http_status(200)
    end
  end
end
