class AddDescriptionToMeals < ActiveRecord::Migration[6.0]
  def change
    add_column :meals, :description, :text
  end
end
