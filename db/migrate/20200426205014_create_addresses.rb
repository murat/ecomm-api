class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :title
      t.text :address
      t.string :country
      t.string :city
      t.string :county
      t.string :zip_code
      t.string :phone

      t.timestamps
    end
  end
end
