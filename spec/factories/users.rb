# frozen_string_literal: true
FactoryBot.define do
  factory :user do
    before(:create, &:skip_confirmation!)

    name { Faker::Name.first_name }
    surname { Faker::Name.last_name }
    phone { Faker::PhoneNumber.phone_number }

    sequence(:email) { |n| "#{name.downcase}.#{surname.downcase}.#{n}@#{Faker::Internet.domain_name}" }
    password { Faker::Internet.password }
    password_confirmation { password }
  end
end
