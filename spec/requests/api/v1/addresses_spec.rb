# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Api::V1::Addresses', type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:access) { FactoryBot.create(:access_token, resource_owner_id: user.id) }
  let!(:addresses) { FactoryBot.create_list(:address, 3) }
  let!(:address) { addresses.first }
  let!(:address_params) { FactoryBot.attributes_for(:address) }
  let!(:invalid_address_params) { { title: nil } }

  describe 'GET /api/v1/addresses' do
    it 'returns unauthorized if header does not exist.' do
      get api_v1_addresses_path

      expect(response).to have_http_status(401)
    end

    it 'works!' do
      get api_v1_addresses_path, params: {}, headers: { authorization: "Bearer #{access.token}" }

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).dig('data').length).to eq(3)
    end
  end

  describe 'POST /api/v1/addresses' do
    it 'works with valid params' do
      post api_v1_addresses_path, params: { address: address_params }, headers: { authorization: "Bearer #{access.token}" }

      expect(response).to have_http_status(201)
      expect(JSON.parse(response.body).dig('data', 'attributes', 'title')).to eq(address_params[:title])
    end

    it 'does not works with invalid params' do
      post api_v1_addresses_path, params: { address: invalid_address_params }, headers: { authorization: "Bearer #{access.token}" }

      expect(response).to have_http_status(422)
      expect(JSON.parse(response.body).dig('errors')).to_not eq(nil)
    end
  end

  describe 'GET /api/v1/addresses/:id' do
    it 'returns not found if record does not exist' do
      get api_v1_address_path(0), params: {}, headers: { authorization: "Bearer #{access.token}" }

      expect(response).to have_http_status(404)
    end

    it 'works!' do
      get api_v1_address_path(address), params: {}, headers: { authorization: "Bearer #{access.token}" }

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).dig('data', 'attributes', 'title')).to eq(address.title)
    end
  end

  describe 'PUT /api/v1/addresses/:id' do
    it 'works with valid params' do
      put api_v1_address_path(address), params: { address: address_params }, headers: { authorization: "Bearer #{access.token}" }

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).dig('data', 'attributes', 'title')).to eq(address_params[:title])
    end

    it 'does not works with valid params' do
      put api_v1_address_path(address), params: { address: invalid_address_params }, headers: { authorization: "Bearer #{access.token}" }

      expect(response).to have_http_status(422)
      expect(JSON.parse(response.body).dig('errors')).to_not eq(nil)
    end
  end

  describe 'DELETE /api/v1/addresses/:id' do
    it 'returns no content if record was exist' do
      delete api_v1_address_path(address), params: {}, headers: { authorization: "Bearer #{access.token}" }

      expect(response).to have_http_status(204)
    end
  end
end
