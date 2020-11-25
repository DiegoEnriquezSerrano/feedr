class AddDefaultAddressColumnToCustomerAddress < ActiveRecord::Migration[6.0]
  def change
    add_column :customer_addresses, :default_address, :boolean, default: false
  end
end
