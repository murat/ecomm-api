# frozen_string_literal: true
require 'rails_helper'

RSpec.describe CartsProduct, type: :model do
  it { should belong_to(:cart) }
  it { should belong_to(:product) }
end
