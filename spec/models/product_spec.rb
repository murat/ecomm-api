# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Product, type: :model do
  it { should belong_to(:brand) }
  it { should belong_to(:category) }
  it { should have_many(:specifications).dependent(:destroy) }

  it { should accept_nested_attributes_for(:specifications).allow_destroy(true) }
  it { should have_many(:discounts).dependent(:destroy) }
  it { should accept_nested_attributes_for(:discounts).allow_destroy(true) }

  it { should have_many(:orders_products).dependent(:restrict_with_error) }
  it { should have_many(:orders).through(:orders_products) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:price) }
end
