# frozen_string_literal: true
FactoryBot.define do
  factory :order do
    user
    order_no { SecureRandom.hex(8) }
    status { 'pending' }
    shipping_address { address }
    invoice_address { address }
  end
end
