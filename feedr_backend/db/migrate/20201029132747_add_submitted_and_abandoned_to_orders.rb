class AddSubmittedAndAbandonedToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :submitted, :boolean
    add_column :orders, :submitted_on, :date
    add_column :orders, :abandoned, :boolean
    add_column :orders, :abandoned_on, :date
  end
end
