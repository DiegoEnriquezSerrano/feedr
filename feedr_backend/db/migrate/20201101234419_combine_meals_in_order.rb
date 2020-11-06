class CombineMealsInOrder < ActiveRecord::Migration[6.0]
  def up
    Order.all.each do |order|
      sums = order.order_meals.group(:meal_id).sum(:total_servings)

      sums.each do |meal_id, total_servings|
        if total_servings > 1
          order.order_meals.where(meal_id: meal_id).delete_all

          meal = order.order_meals.build(meal_id: meal_id)
          meal.total_servings = total_servings
          meal.save!
        end
      end
    end
  end

  def down
    OrderMeal.where("total_servings>1").each do |order_meal|
      order_meal.total_servings.times do
        OrderMeal.create(
          order_id: order_meal.order_id,
          meal_id: order_meal.meal_id,
          quantity: 1
        )
      end
      order_meal.destroy!
    end
  end
end
