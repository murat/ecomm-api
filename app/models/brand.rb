# frozen_string_literal: true
class Brand < ApplicationRecord
  has_many :products, dependent: :nullify

  validates :name, presence: true
end
