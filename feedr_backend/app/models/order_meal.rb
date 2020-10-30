class OrderMeal < ApplicationRecord
  belongs_to :order
  belongs_to :meal

  before_save :set_unit_price
  before_save :set_subtotal

  validates :total_servings, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

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

  private
  def set_unit_price
    self[:unit_price] = unit_price
  end

  def set_subtotal
    self[:subtotal] = subtotal * total_servings
  end
end
