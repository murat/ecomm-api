# frozen_string_literal: true
class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.string :order_no, null: false, unique: true
      t.string :status
      t.references :shipping_address, null: false, foreign_key: { to_table: :addresses }
      t.references :invoice_address, null: false, foreign_key: { to_table: :addresses }

      t.timestamps
    end
  end
end
