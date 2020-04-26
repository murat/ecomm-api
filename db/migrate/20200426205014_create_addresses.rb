class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.references :user, null: false, foreign_key: true
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
