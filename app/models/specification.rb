# frozen_string_literal: true
class Specification < ApplicationRecord
  belongs_to :product

  validates :spec_key, presence: true, uniqueness: { scope: :product_id, case_sensitive: false }
  validates :spec_val, presence: true
end
