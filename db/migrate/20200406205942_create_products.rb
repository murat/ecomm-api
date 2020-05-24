# frozen_string_literal: true
class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products, id: :uuid do |t|
      t.string :slug
      t.string :name, null: false
      t.text :description
      t.decimal :price, default: 0.0
      t.integer :stock, null: false, default: 0
      t.integer :purchase_limit, null: false, default: 0
      t.references :brand, foreign_key: true, type: :uuid
      t.references :category, foreign_key: true, type: :uuid

      t.timestamps
    end
    add_index :products, :slug, unique: true
  end
end
