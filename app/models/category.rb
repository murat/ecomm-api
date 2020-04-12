# frozen_string_literal: true
class Category < ApplicationRecord
  has_ancestry
  acts_as_list scope: [:ancestry]

  has_many :products, dependent: :nullify

  validates :name, presence: true
end
