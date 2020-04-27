# frozen_string_literal: true
class Order < ApplicationRecord
  ORDER_NO_STARTS = 10_000
  ORDER_NO_PREFIX = 'ECOMM-'
  ORDER_NO_SUFFIX = ''

  belongs_to :user
  belongs_to :shipping_address, class_name: 'Address'
  belongs_to :invoice_address, class_name: 'Address'
  has_many :orders_products, dependent: :destroy
  has_many :products, -> { readonly }, through: :orders_products

  validates :order_no, presence: true
  validates :order_no, uniqueness: true
  validates :shipping_address_id, presence: true
  validates :invoice_address_id, presence: true

  def next_order_no
    last_order = self.class.order(created_at: :desc).limit(1).first
    return "#{ORDER_NO_PREFIX}#{ORDER_NO_STARTS}#{ORDER_NO_SUFFIX}" if last_order.nil?

    matches = last_order.order_no.match(Regexp.new("#{ORDER_NO_PREFIX}(\\d+)#{ORDER_NO_SUFFIX}"))
    next_no = matches[1].to_i + 1
    "#{ORDER_NO_PREFIX}#{next_no}#{ORDER_NO_SUFFIX}"
  end
end
