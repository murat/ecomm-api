# frozen_string_literal: true
class Discount < ApplicationRecord
  belongs_to :product

  validates :discount, presence: true
end
