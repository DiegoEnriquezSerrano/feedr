require 'rails_helper'

RSpec.describe "OrderMeals", type: :request do
  fixtures :users, :meals

  describe 'POST /order_meals' do
    context 'user is not logged in' do
      it 'is not ok' do
        post order_meals_path, params: { order_meal: { meal_id: '1', total_servings: '5' } }
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'user is logged in' do
      before(:each) {
        my_cookies = ActionDispatch::Request.new(Rails.application.env_config.deep_dup).cookie_jar
        my_cookies.signed[:jwt] = ENV['CUSTOMER_JWT']
        cookies[:jwt] = my_cookies[:jwt]
      }
      it 'it is fine' do
        post order_meals_path, params: { order_meal: { meal_id: '1', total_servings: '5' } }
        expect(response).to have_http_status(:created)
      end

      it 'it is not ok if order meal servings dont reach required minimum' do
        post order_meals_path, params: { order_meal: { meal_id: '1', total_servings: '3' } }
        expect(response).to have_http_status(:forbidden)
      end

      context 'meal that belongs to different caterer than meals in current order' do
        before(:example) {
          @customer = User.find(users(:customer).id)
          @caterer = User.find(users(:caterer).id)
          @meal = Meal.where(user_id: @caterer.id).last
          @order = Order.new(customer: @customer, caterer: @caterer)
          @order_meal = OrderMeal.new(order: @order, meal: @meal, total_servings: @meal.servings_minimum)
          @order.save && @order_meal.save
        }
        it 'will fail' do
          post order_meals_path, params: { order_meal: { meal_id: '2', total_servings: '5' } }
          expect(response).to have_http_status(:forbidden)
        end
      end
    end
  end
end
