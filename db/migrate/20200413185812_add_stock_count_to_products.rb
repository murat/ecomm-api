# frozen_string_literal: true
class AddStockCountToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :stock_count, :integer, null: false, default: 0
  end
end
