# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Carts', type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:cart) { FactoryBot.create(:cart, user_id: user.id) }
  let!(:public_access) { FactoryBot.create(:access_token, resource_owner_id: user.id) }
  let!(:cart_products) { FactoryBot.create_list(:carts_product, 3, cart_id: cart.id) }
  let!(:cart_products_params) { { product_id: cart_products.first&.product_id, amount: 1 } }

  describe 'GET /cart' do
    it 'works!' do
      get api_v1_cart_path, params: {}, headers: { authorization: "Bearer #{public_access.token}" }

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).dig('data').length).to eq(3)
    end

    it 'does not works \wo authorization' do
      get api_v1_cart_path, params: {}

      expect(response).to have_http_status(401)
    end
  end

  describe 'POST /cart/add' do
    it 'works!' do
      post api_v1_cart_add_path, params: cart_products_params,
                                 headers: { authorization: "Bearer #{public_access.token}" }

      expect(response).to have_http_status(200)
    end
  end

  describe 'DELETE /cart/drop/:product_id' do
    it 'works!' do
      delete api_v1_cart_drop_path(cart_products.first&.product_id),
             headers: { authorization: "Bearer #{public_access.token}" }

      expect(response).to have_http_status(200)
    end
  end

  describe 'PUT /cart/update/:product_id' do
    it 'works!' do
      put api_v1_cart_update_path(cart_products.first&.product_id), params: { amount: 1 },
                                                                   headers: { authorization: "Bearer #{public_access.token}" }

      expect(response).to have_http_status(200)
    end
  end

  describe 'PUT /cart/increment/:product_id' do
    it 'works!' do
      put api_v1_cart_increment_path(cart_products.first&.product_id),
          headers: { authorization: "Bearer #{public_access.token}" }

      expect(response).to have_http_status(200)
    end
  end

  describe 'PUT /cart/decrement/:product_id' do
    it 'works!' do
      put api_v1_cart_decrement_path(cart_products.first&.product_id),
          headers: { authorization: "Bearer #{public_access.token}" }

      expect(response).to have_http_status(200)
    end
  end
end
