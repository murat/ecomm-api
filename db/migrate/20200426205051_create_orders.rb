# frozen_string_literal: true
class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :status
      t.references :shipping_address, null: false, foreign_key: { to_table: :addresses }, type: :uuid
      t.references :invoice_address, null: false, foreign_key: { to_table: :addresses }, type: :uuid

      t.timestamps
    end
  end
end
