# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Cart, type: :model do
  it { should have_many(:carts_products).dependent(:destroy) }
  it { should have_many(:products).through(:carts_products) }
end
