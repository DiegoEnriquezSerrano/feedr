class CreateCustomerAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :customer_addresses do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :name, null: true
      t.string :address, null: false
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
  end
end
