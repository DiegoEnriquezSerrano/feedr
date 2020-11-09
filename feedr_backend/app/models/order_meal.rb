class OrderMeal < ApplicationRecord
  belongs_to :order
  belongs_to :meal

  before_save :set_unit_price
  before_save :set_subtotal

  validates :meal_id, presence: true
  validates :total_servings, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validate :validate_meal_belongs_to_order_caterer

  def unit_price
    if persisted?
      self[:unit_price]
    else
      meal.price_minimum/meal.servings_minimum
    end
  end

  def subtotal
    unit_price * total_servings
  end

  def validate_order_minimum_is_reached(servings)
    if servings < meal.servings_minimum
      return false
    else
      return true
    end
  end

  private
  def set_unit_price
    self[:unit_price] = unit_price
  end

  def set_subtotal
    self[:subtotal] = subtotal * total_servings
  end

  def validate_meal_belongs_to_order_caterer
    unless order.caterer == meal.user
      errors.add(:base, 'Does not belong to current order')
      throw :abort
    end
  end
end
