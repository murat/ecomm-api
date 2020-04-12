# frozen_string_literal: true
class CreateDiscounts < ActiveRecord::Migration[6.0]
  def change
    create_table :discounts do |t|
      t.references :product, null: false, foreign_key: true
      t.decimal :discount, null: false
      t.datetime :start_time
      t.datetime :end_time
      t.boolean :active, null: false, default: true

      t.timestamps
    end
  end
end
