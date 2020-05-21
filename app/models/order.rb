# frozen_string_literal: true
class Order < ApplicationRecord
  belongs_to :user
  belongs_to :shipping_address, class_name: 'Address'
  belongs_to :invoice_address, class_name: 'Address'
  has_many :orders_products, dependent: :destroy
  has_many :products, -> { readonly }, through: :orders_products

  validates :order_no, presence: true
  validates :order_no, uniqueness: true
  validates :shipping_address_id, presence: true
  validates :invoice_address_id, presence: true

  def self.order_no=(_val)
    SecureRandom.uuid
  end
end
