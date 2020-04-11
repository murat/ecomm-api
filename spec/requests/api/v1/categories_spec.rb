# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  let!(:token) { FactoryBot.create(:oauth_token).token }
  let!(:categories) { FactoryBot.create_list(:category, 10) }
  let!(:category) { categories.first }
  let!(:category_params) { FactoryBot.attributes_for(:category) }
  let!(:invalid_category_params) { { name: nil } }

  describe 'GET /api/v1/categories' do
    it 'returns unauthorized if header does not exist.' do
      get api_v1_categories_path

      expect(response).to have_http_status(401)
    end

    it 'works!' do
      get api_v1_categories_path, params: {}, headers: { authorization: "Bearer #{token}" }

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).length).to eq(10)
    end
  end

  describe 'POST /api/v1/categories' do
    it 'works with valid params' do
      post api_v1_categories_path, params: { category: category_params }, headers: { authorization: "Bearer #{token}" }

      expect(response).to have_http_status(201)
      expect(JSON.parse(response.body).dig('name')).to eq(category_params[:name])
    end

    it 'does not works with invalid params' do
      post api_v1_categories_path, params: { category: invalid_category_params }, headers: { authorization: "Bearer #{token}" }

      expect(response).to have_http_status(422)
      expect(JSON.parse(response.body).dig('errors')).to_not eq(nil)
    end
  end

  describe 'GET /api/v1/categories/:id' do
    it 'returns not found if record does not exist' do
      get api_v1_category_path(0), params: {}, headers: { authorization: "Bearer #{token}" }

      expect(response).to have_http_status(404)
    end

    it 'works!' do
      get api_v1_category_path(category), params: {}, headers: { authorization: "Bearer #{token}" }

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).dig('name')).to eq(category.name)
    end
  end

  describe 'PUT /api/v1/categories/:id' do
    it 'works with valid params' do
      put api_v1_category_path(category), params: { category: category_params }, headers: { authorization: "Bearer #{token}" }

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).dig('name')).to eq(category_params[:name])
    end

    it 'does not works with valid params' do
      put api_v1_category_path(category), params: { category: invalid_category_params }, headers: { authorization: "Bearer #{token}" }

      expect(response).to have_http_status(422)
      expect(JSON.parse(response.body).dig('errors')).to_not eq(nil)
    end
  end

  describe 'PUT /api/v1/categories/:id' do
    it 'works with valid params' do
      put api_v1_category_path(category), params: { category: category_params }, headers: { authorization: "Bearer #{token}" }

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).dig('name')).to eq(category_params[:name])
    end

    it 'does not works with valid params' do
      put api_v1_category_path(category), params: { category: invalid_category_params }, headers: { authorization: "Bearer #{token}" }

      expect(response).to have_http_status(422)
      expect(JSON.parse(response.body).dig('errors')).to_not eq(nil)
    end
  end

  describe 'DELETE /api/v1/categories/:id' do
    it 'returns no content if record was exist' do
      delete api_v1_category_path(category), params: {}, headers: { authorization: "Bearer #{token}" }

      expect(response).to have_http_status(204)
    end
  end
end
