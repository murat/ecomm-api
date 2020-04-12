# frozen_string_literal: true
class Product < ApplicationRecord
  belongs_to :brand, optional: true
  belongs_to :category, optional: true
  has_many :images, as: :imageable, dependent: :destroy
  has_many :specifications, dependent: :destroy

  validates :name, presence: true
  validates :price, presence: true
end
