# frozen_string_literal: true
class CreateBrands < ActiveRecord::Migration[6.0]
  def change
    create_table :brands, id: :uuid do |t|
      t.string :slug
      t.string :name, null: false
      t.text :description

      t.timestamps
    end
    add_index :brands, :slug, unique: true
  end
end
