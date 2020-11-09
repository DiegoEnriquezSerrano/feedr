require 'rails_helper'

describe OrderMeal do
  fixtures :users, :meals

  context 'creating an order meal' do
    before(:each) {
      @customer = User.find(users(:customer).id)
      @caterer = User.find(users(:caterer).id)
      @meal = Meal.where(user_id: @caterer.id).last
      @second_meal = Meal.where(user_id: users(:second_caterer).id).last
      @order = Order.new(
        customer: @customer,
        caterer: @caterer,
        submitted: false,
        abandoned: false,
        submitted_on: nil,
        abandoned_on: nil
      )
      @order_meal = OrderMeal.new(order: @order, meal: @meal)
    }

    context 'is not valid if order' do
      it 'doesnt have servings' do
        expect(@order_meal).to be_invalid
      end
      
      it 'meal doesnt belong to order caterer' do
        @order_meal.total_servings = @meal.servings_minimum+1
        @order_meal.meal = @second_meal
        expect(@order_meal).to be_invalid
      end
    end

    context 'is valid if order' do
      it 'has servings' do
        @order_meal.total_servings = @meal.servings_minimum+1
        expect(@order_meal).to be_valid
      end
    end
  end
end
