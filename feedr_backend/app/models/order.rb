class Order < ApplicationRecord
  belongs_to :customer, class_name: "User"
  belongs_to :caterer, class_name: "User"

  validates :submitted, inclusion: { in: [true, false] }
  validates :abandoned, inclusion: { in: [true, false] }
  validates :accepted, inclusion: { in: [true, false] }
  validates :subtotal, numericality: { greater_than_or_equal_to: 0.01 }, if: -> (o) { !o.order_meals.empty? }

  has_many :order_meals, dependent: :destroy
  before_save :set_subtotal
  before_save :update_timestamp

  def subtotal
    order_meals.collect{ |order_meal| order_meal.valid? ? order_meal.unit_price*order_meal.total_servings : 0}.sum
  end

  def set_order_meal(meal_id, total_servings)
    order_meal = order_meals.find_by(meal_id: meal_id) || order_meals.new(meal_id: meal_id)
    order_meal.total_servings = total_servings
    return order_meal
  end

  private
  def set_subtotal
    self[:subtotal] = subtotal
  end

  def update_timestamp
    self[:updated_at] = Time.now
  end
end
