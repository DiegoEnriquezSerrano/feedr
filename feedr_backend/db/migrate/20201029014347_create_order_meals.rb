class CreateOrderMeals < ActiveRecord::Migration[6.0]
  def change
    create_table :order_meals do |t|
      t.belongs_to :order, null: false, foreign_key: true
      t.belongs_to :meal, foreign_key: true
      t.integer :total_servings
      t.decimal :subtotal
      t.timestamps
    end
  end
end
