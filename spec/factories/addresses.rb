# frozen_string_literal: true
FactoryBot.define do
  factory :address do
    user
    title { Faker::Lorem.word }
    address { Faker::Address.full_address }
    country { Faker::Address.country }
    city { Faker::Address.city }
    county { Faker::Address.community }
    zip_code { Faker::Address.zip }
    phone { Faker::PhoneNumber.cell_phone }
  end
end
