class CreateOrdersProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :orders_products do |t|
      t.references :order, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :amount
      t.decimal :price

      t.timestamps
    end
  end
end
