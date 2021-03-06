# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Products', type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:public_access) { FactoryBot.create(:access_token, resource_owner_id: user.id) }
  let!(:admin_access) { FactoryBot.create(:access_token, resource_owner_id: user.id, scopes: 'admin') }
  let!(:products) { FactoryBot.create_list(:product, 10) }
  let!(:product) { products.first }
  let!(:product_params) { FactoryBot.attributes_for(:product, :with_specifications, :with_discount) }
  let!(:invalid_product_params) { { name: nil } }

  describe 'GET /api/v1/products' do
    it 'returns unauthorized if header does not exist.' do
      get api_v1_products_path

      expect(response).to have_http_status(401)
    end

    it 'works!' do
      get api_v1_products_path, params: {}, headers: { authorization: "Bearer #{public_access.token}" }

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).dig('data').length).to eq(10)
    end
  end

  describe 'POST /api/v1/products' do
    it 'returns unauthorized without sudo token' do
      post api_v1_products_path, params: { product: product_params }, headers: { authorization: "Bearer #{public_access.token}" }

      expect(response).to have_http_status(403)
    end

    it 'works with valid params' do
      post api_v1_products_path, params: { product: product_params }, headers: { authorization: "Bearer #{admin_access.token}" }

      expect(response).to have_http_status(201)
      expect(JSON.parse(response.body).dig('data', 'attributes', 'name')).to eq(product_params[:name])
      expect(JSON.parse(response.body).dig('data', 'relationships', 'specifications', 'data').length).to eq(2)
      expect(JSON.parse(response.body).dig('data', 'relationships', 'discounts', 'data').length).to eq(1)
    end

    it 'does not works with invalid params' do
      post api_v1_products_path, params: { product: invalid_product_params }, headers: { authorization: "Bearer #{admin_access.token}" }

      expect(response).to have_http_status(422)
      expect(JSON.parse(response.body).dig('errors')).to_not eq(nil)
    end
  end

  describe 'GET /api/v1/products/:id' do
    it 'returns not found if record does not exist' do
      get api_v1_product_path(0), params: {}, headers: { authorization: "Bearer #{public_access.token}" }

      expect(response).to have_http_status(404)
    end

    it 'works!' do
      get api_v1_product_path(product), params: {}, headers: { authorization: "Bearer #{public_access.token}" }

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).dig('data', 'attributes', 'name')).to eq(product.name)
    end
  end

  describe 'PUT /api/v1/products/:id' do
    it 'returns unauthorized without sudo token' do
      post api_v1_products_path, params: { product: product_params }, headers: { authorization: "Bearer #{public_access.token}" }

      expect(response).to have_http_status(403)
    end

    it 'works with valid params' do
      put api_v1_product_path(product), params: { product: product_params }, headers: { authorization: "Bearer #{admin_access.token}" }

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).dig('data', 'attributes', 'name')).to eq(product_params[:name])
    end

    it 'does not works with valid params' do
      put api_v1_product_path(product), params: { product: invalid_product_params }, headers: { authorization: "Bearer #{admin_access.token}" }

      expect(response).to have_http_status(422)
      expect(JSON.parse(response.body).dig('errors')).to_not eq(nil)
    end
  end

  describe 'DELETE /api/v1/products/:id' do
    it 'returns unauthorized without sudo token' do
      post api_v1_products_path, params: { product: product_params }, headers: { authorization: "Bearer #{public_access.token}" }

      expect(response).to have_http_status(403)
    end

    it 'returns no content if record was exist' do
      delete api_v1_product_path(product), params: {}, headers: { authorization: "Bearer #{admin_access.token}" }

      expect(response).to have_http_status(204)
    end
  end
end
