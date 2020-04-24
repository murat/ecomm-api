# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Brands', type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:public_access) { FactoryBot.create(:access_token, resource_owner_id: user.id) }
  let!(:admin_access) { FactoryBot.create(:access_token, resource_owner_id: user.id, scopes: 'admin') }
  let!(:brands) { FactoryBot.create_list(:brand, 10) }
  let!(:brand) { brands.first }
  let!(:brand_params) { FactoryBot.attributes_for(:brand) }
  let!(:invalid_brand_params) { { name: nil } }

  describe 'GET /api/v1/brands' do
    it 'returns unauthorized if header does not exist.' do
      get api_v1_brands_path

      expect(response).to have_http_status(401)
    end

    it 'works!' do
      get api_v1_brands_path, params: {}, headers: { authorization: "Bearer #{public_access.token}" }

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).dig('data').length).to eq(10)
    end
  end

  describe 'POST /api/v1/brands' do
    it 'returns unauthorized without sudo token' do
      post api_v1_brands_path, params: { brand: brand_params }, headers: { authorization: "Bearer #{public_access.token}" }

      expect(response).to have_http_status(403)
    end

    it 'works with valid params' do
      post api_v1_brands_path, params: { brand: brand_params }, headers: { authorization: "Bearer #{admin_access.token}" }

      expect(response).to have_http_status(201)
      expect(JSON.parse(response.body).dig('data', 'attributes', 'name')).to eq(brand_params[:name])
    end

    it 'does not works with invalid params' do
      post api_v1_brands_path, params: { brand: invalid_brand_params }, headers: { authorization: "Bearer #{admin_access.token}" }

      expect(response).to have_http_status(422)
      expect(JSON.parse(response.body).dig('errors')).to_not eq(nil)
    end
  end

  describe 'GET /api/v1/brands/:id' do
    it 'returns not found if record does not exist' do
      get api_v1_brand_path(0), params: {}, headers: { authorization: "Bearer #{public_access.token}" }

      expect(response).to have_http_status(404)
    end

    it 'works!' do
      get api_v1_brand_path(brand), params: {}, headers: { authorization: "Bearer #{public_access.token}" }

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).dig('data', 'attributes', 'name')).to eq(brand.name)
    end
  end

  describe 'PUT /api/v1/brands/:id' do
    it 'returns unauthorized without sudo token' do
      put api_v1_brand_path(brand), params: { brand: brand_params }, headers: { authorization: "Bearer #{public_access.token}" }

      expect(response).to have_http_status(403)
    end

    it 'works with valid params' do
      put api_v1_brand_path(brand), params: { brand: brand_params }, headers: { authorization: "Bearer #{admin_access.token}" }

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).dig('data', 'attributes', 'name')).to eq(brand_params[:name])
    end

    it 'does not works with valid params' do
      put api_v1_brand_path(brand), params: { brand: invalid_brand_params }, headers: { authorization: "Bearer #{admin_access.token}" }

      expect(response).to have_http_status(422)
      expect(JSON.parse(response.body).dig('errors')).to_not eq(nil)
    end
  end

  describe 'DELETE /api/v1/brands/:id' do
    it 'returns unauthorized without sudo token' do
      delete api_v1_brand_path(brand), params: {}, headers: { authorization: "Bearer #{public_access.token}" }

      expect(response).to have_http_status(403)
    end

    it 'returns no content if record was exist' do
      delete api_v1_brand_path(brand), params: {}, headers: { authorization: "Bearer #{admin_access.token}" }

      expect(response).to have_http_status(204)
    end
  end
end
