# frozen_string_literal: true
FactoryBot.define do
  factory :access_token, class: 'Doorkeeper::AccessToken' do
    application { nil }
    resource_owner_id { FactoryBot.create(:user).id }
  end
end
