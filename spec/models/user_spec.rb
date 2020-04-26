# frozen_string_literal: true
require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:access_grants).class_name('Doorkeeper::AccessGrant').with_foreign_key(:resource_owner_id).dependent(:delete_all) }
  it { should have_many(:access_tokens).class_name('Doorkeeper::AccessToken').with_foreign_key(:resource_owner_id).dependent(:delete_all) }
  it { should have_many(:addresses).dependent(:destroy) }
  it { should have_many(:orders).dependent(:destroy) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:surname) }
  it { should validate_presence_of(:phone) }
end
