require 'rails_helper'

RSpec.describe "NewOrders", type: :request do
  fixtures :users, :meals
  before(:each) {
    my_cookies = ActionDispatch::Request.new(Rails.application.env_config.deep_dup).cookie_jar
    my_cookies.signed[:jwt] = ENV['CUSTOMER_JWT']
    cookies[:jwt] = my_cookies[:jwt]
  }

  describe 'GET /order/new' do
    before(:example) { get new_order_path } 
    it "is a success" do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /order/new' do
    context 'if current order is empty' do
      before(:example) { post new_order_path }
      it "is unsuccessful if current order is empty" do
        expect(response).to have_http_status(:not_acceptable)
      end
    end

    context 'if current order is not empty' do
      it "is successful if current order has order meals" do
        @customer = User.find(users(:customer).id)
        @caterer = User.find(users(:caterer).id)
        @meal = Meal.where(user_id: @caterer.id).last
        @order = Order.new(
          customer: @customer,
          caterer: @caterer,
          submitted: false,
          abandoned: false,
          submitted_on: nil,
          abandoned_on: nil
        )
        @order_meal = OrderMeal.new(order: @order, meal: @meal, total_servings: @meal.servings_minimum)
        @order.save && @order_meal.save
        post new_order_path
        expect(response).to have_http_status(:created)
      end
    end
  end

  describe 'GET /current_order' do
    context 'if current order is empty' do
      before(:each) {
        get current_order_path
      }
      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'order_meals is empty' do
        json_response = JSON.parse(response.body)
        expect(json_response["order_meals"]).to be_empty
      end
    end

    context 'if current order has order meals' do
      before(:example) {
        @customer = User.find(users(:customer).id)
        @caterer = User.find(users(:caterer).id)
        @meal = Meal.where(user_id: @caterer.id).last
        @order = Order.new(
          customer: @customer,
          caterer: @caterer,
          submitted: false,
          abandoned: false,
          submitted_on: nil,
          abandoned_on: nil
        )
        @order_meal = OrderMeal.new(order: @order, meal: @meal, total_servings: @meal.servings_minimum)
        @order.save && @order_meal.save
      }

      it 'expects order_meals to not be empty' do
        get current_order_path
        json_response = JSON.parse(response.body)
        expect(json_response['order_meals'][0].keys).to match_array(["meal_id", "total_servings"])
      end
    end
  end
end
