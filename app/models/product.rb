# frozen_string_literal: true
class Product < ApplicationRecord
  belongs_to :brand, optional: true
  belongs_to :category, optional: true
  has_many :images, as: :imageable, dependent: :destroy

  has_many :specifications, inverse_of: :product, dependent: :destroy
  accepts_nested_attributes_for :specifications, allow_destroy: true
  has_many :discounts, inverse_of: :product, dependent: :destroy
  accepts_nested_attributes_for :discounts, allow_destroy: true

  validates :name, presence: true
  validates :price, presence: true
end
