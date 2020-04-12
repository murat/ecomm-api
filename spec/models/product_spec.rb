# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Product, type: :model do
  it { should belong_to(:brand) }
  it { should belong_to(:category) }
  it { should have_many(:specifications).dependent(:destroy) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:price) }
end
