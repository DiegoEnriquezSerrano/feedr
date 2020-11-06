class Order < ApplicationRecord
  belongs_to :customer, class_name: "User"
  belongs_to :caterer, class_name: "User"

  validates :submitted, inclusion: { in: [true, false] }
  validates :abandoned, inclusion: { in: [true, false] }
  validates :accepted, inclusion: { in: [true, false] }
  validates :subtotal, numericality: { greater_than_or_equal_to: 0.01 }, if: -> (o) { !o.order_meals.empty? }

  has_many :order_meals, dependent: :destroy
  before_save :set_subtotal

  def subtotal
    order_meals.collect{ |order_meal| order_meal.valid? ? order_meal.unit_price*order_meal.total_servings : 0}.sum
  end

  private
  def set_subtotal
    self[:subtotal] = subtotal
  end
end
