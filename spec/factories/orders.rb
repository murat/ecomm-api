# frozen_string_literal: true
FactoryBot.define do
  factory :order do
    user
    sequence :order_no do |n|
      "ECOMM-1000#{n}"
    end
    status { 'pending' }
    shipping_address_id { FactoryBot.create(:address).id }
    invoice_address_id { FactoryBot.create(:address).id }
  end
end
