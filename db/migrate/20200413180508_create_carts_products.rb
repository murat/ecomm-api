# frozen_string_literal: true
class CreateCartsProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :carts_products do |t|
      t.references :cart, null: false, foreign_key: true, type: :uuid
      t.references :product, null: false, foreign_key: true, type: :uuid
      t.integer :amount, null: false, default: 0

      t.timestamps
    end
  end
end
