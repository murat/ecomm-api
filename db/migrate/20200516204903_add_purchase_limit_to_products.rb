# frozen_string_literal: true
class AddPurchaseLimitToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :purchase_limit, :integer, default: 0
    rename_column :products, :stock_count, :stock
  end
end
