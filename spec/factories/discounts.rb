# frozen_string_literal: true
FactoryBot.define do
  factory :discount do
    product
    discount { (0..50).to_a.sample }
    start_time { Time.now.utc - 2.days }
    end_time { Time.now.utc + 3.days }
    active { true }
  end
end
