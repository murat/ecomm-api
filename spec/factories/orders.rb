# frozen_string_literal: true
FactoryBot.define do
  factory :order do
    user
    status { 'pending' }
    shipping_address_id { FactoryBot.create(:address).id }
    invoice_address_id { FactoryBot.create(:address).id }
  end
end
