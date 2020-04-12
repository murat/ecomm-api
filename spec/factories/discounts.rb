# frozen_string_literal: true
FactoryBot.define do
  factory :discount do
    product
    discount { '9.99' }
    start_time { '2020-04-12 15:36:35' }
    end_time { '2020-04-12 15:36:35' }
    active { true }
  end
end
