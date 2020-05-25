# frozen_string_literal: true
class Product < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :brand, optional: true
  belongs_to :category, optional: true
  has_many :images, as: :imageable, dependent: :destroy

  has_many :specifications, inverse_of: :product, dependent: :destroy
  accepts_nested_attributes_for :specifications, allow_destroy: true
  has_many :all_discounts, class_name: 'Discount', inverse_of: :product, dependent: :destroy
  has_many :discounts,
           -> { where('start_time <= :now and end_time >= :now', now: Time.now.utc).where(active: true).order(discount: :asc) },
           inverse_of: :product
  accepts_nested_attributes_for :discounts, allow_destroy: true

  has_many :orders_products, dependent: :restrict_with_error
  has_many :orders, through: :orders_products

  validates :name, presence: true
  validates :price, presence: true

  def discounted_price
    discounts.reduce(price) do |m, x|
      m - m * x.discount / 100.to_f
    end
  end

  def available_stock
    stock - CartsProduct.sum(:amount)
  end
end
