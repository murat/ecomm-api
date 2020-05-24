# frozen_string_literal: true
class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories, id: :uuid do |t|
      t.string :ancestry, index: true
      t.integer :position
      t.string :slug
      t.string :name, null: false

      t.timestamps
    end
    add_index :categories, :slug, unique: true
  end
end
