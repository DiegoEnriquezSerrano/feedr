class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.belongs_to :customer, null: false, foreign_key: { to_table: 'users' }
      t.belongs_to :caterer, null: false, foreign_key: { to_table: 'users' }
      t.timestamps
    end
  end
end
