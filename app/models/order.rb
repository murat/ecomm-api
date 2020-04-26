# frozen_string_literal: true
class Order < ApplicationRecord
  # ORDER_NO_STARTS = 10_000
  # ORDER_NO_PREFIX = ''
  # ORDER_NO_SUFFIX = ''

  belongs_to :user
  belongs_to :shipping_address, class_name: 'Address'
  belongs_to :invoice_address, class_name: 'Address'
  has_many :orders_products, dependent: :destroy
  has_many :products, -> { readonly }, through: :orders_products

  validates :order_no, presence: true, uniqueness: true
  validates :shipping_address_id, presence: true
  validates :invoice_address_id, presence: true

  # def next_order_no
  #   match = self.class.order(created_at: :desc).limit(1).first&.order_no&.match(Regex.new(ORDER_NO_PREFIX + "(\d+)" + ORDER_NO_SUFFIX))
  #   ORDER_NO_PREFIX + ((match&.get(1)&.to_i || ORDER_NO_STARTS) + 1).to_s + ORDER_NO_SUFFIX
  # end
end
