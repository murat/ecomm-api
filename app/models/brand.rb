# frozen_string_literal: true
class Brand < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :products, dependent: :nullify

  validates :name, presence: true
end
