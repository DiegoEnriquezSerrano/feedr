class AddBusinessRadiusToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :business_radius, :integer, null: false, default: 25
  end
end
