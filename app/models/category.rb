# frozen_string_literal: true
class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_ancestry
  acts_as_list scope: [:ancestry]

  has_many :products, dependent: :nullify

  validates :name, presence: true
end
