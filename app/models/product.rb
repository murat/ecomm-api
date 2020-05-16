# frozen_string_literal: true
class Product < ApplicationRecord
  belongs_to :brand, optional: true
  belongs_to :category, optional: true
  has_many :images, as: :imageable, dependent: :destroy

  has_many :specifications, inverse_of: :product, dependent: :destroy
  accepts_nested_attributes_for :specifications, allow_destroy: true
  has_many :discounts, inverse_of: :product, dependent: :destroy
  accepts_nested_attributes_for :discounts, allow_destroy: true

  has_many :orders_products, dependent: :restrict_with_error
  has_many :orders, through: :orders_products

  validates :name, presence: true
  validates :price, presence: true

  def discounted_price
    price - discounts.where('start_time <= :now and end_time >= :now', now: Time.zone.now)
                     .where(active: true)
                     .sum(:discount)
  end

  def available_stock
    stock - CartsProduct.sum(:amount)
  end
end
