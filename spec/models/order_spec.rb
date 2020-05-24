# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Order, type: :model do
  let!(:order) { FactoryBot.create(:order) }

  describe 'active record associations and validations' do
    it { should have_many(:orders_products).dependent(:destroy) }
    it { should have_many(:products).through(:orders_products) }
    it { should belong_to(:shipping_address).class_name('Address') }
    it { should belong_to(:invoice_address).class_name('Address') }
    it { should belong_to(:user) }
  end
end
