# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Order, type: :model do
  let!(:order) { FactoryBot.create(:order, order_no: 'ECOMM-10000') }

  describe 'active record associations and validations' do
    it { should have_many(:orders_products).dependent(:destroy) }
    it { should have_many(:products).through(:orders_products) }
    it { should belong_to(:shipping_address).class_name('Address') }
    it { should belong_to(:invoice_address).class_name('Address') }
    it { should belong_to(:user) }
    it { should validate_presence_of(:order_no) }
    it { should validate_uniqueness_of(:order_no) }
  end
end
