class ChangeSubmittedAndAbandonedDefaultsAndAddAcceptedToOrders < ActiveRecord::Migration[6.0]
  def change
    change_column :orders, :submitted, :boolean, default: false
    change_column :orders, :abandoned, :boolean, default: false
    add_column    :orders, :accepted, :boolean, default: false
    add_column    :orders, :accepted_on, :date
  end
end
