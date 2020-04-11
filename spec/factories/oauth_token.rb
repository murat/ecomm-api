# frozen_string_literal: true
FactoryBot.define do
  factory :oauth_token, class: 'Doorkeeper::AccessToken' do
    use_refresh_token { true }
    expires_in { 7200 }
    resource_owner_id { FactoryBot.create(:user).id }
    scopes { 'read write' }
  end
end
