# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Carts', type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:cart) { FactoryBot.create(:cart, user_id: user.id) }
  let!(:public_access) { FactoryBot.create(:access_token, resource_owner_id: user.id) }
  let!(:cart_products) { FactoryBot.create_list(:carts_product, 3, cart_id: cart.id) }

  describe 'GET /cart' do
    it 'works!' do
      get api_v1_cart_path, params: {}, headers: { authorization: "Bearer #{public_access.token}" }

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).dig('data').length).to eq(3)
    end
  end
end
