class Order < ApplicationRecord
  belongs_to :customer, class_name: "User"
  belongs_to :caterer, class_name: "User"

  has_many :order_meals, dependent: :destroy

  def subtotal
    order_meals.collect{ |order_meal| order_meal.valid? ? order_meal.unit_price*order_meal.total_servings : 0}.sum
  end

  private
  def set_subtotal
    self[:subtotal] = subtotal
  end
end
