# frozen_string_literal: true
class AddPriceToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :price, :decimal, default: 0.0
  end
end
