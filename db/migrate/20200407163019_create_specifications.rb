# frozen_string_literal: true
class CreateSpecifications < ActiveRecord::Migration[6.0]
  def change
    create_table :specifications do |t|
      t.references :product, foreign_key: true, type: :uuid
      t.integer :position, index: true
      t.string :spec_key, index: true
      t.string :spec_val, index: true

      t.timestamps
    end
    add_index :specifications, [:spec_key, :product_id], unique: true
  end
end
