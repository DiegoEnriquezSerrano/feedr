require 'rails_helper'

describe Order do
  fixtures :users, :meals
  
  context 'creating a new order' do
    before(:each) { 
      @customer = User.find(users(:customer).id)
      @caterer = User.find(users(:caterer).id)
    }

    it 'needs to have a customer' do
      order = Order.new(caterer: @caterer)
      expect(order).to be_invalid
    end

    it 'needs to have a caterer' do
      order = Order.new(customer: @customer)
      expect(order).to be_invalid
    end

    context 'that has a customer and caterer' do
      before(:each) {
        @order = Order.new(customer: @customer, caterer: @caterer)
      }
      context 'should be successfully saved' do
        before(:each) {
          @order.save
        }
        it 'unless order event flag isnt set' do
          @order.update(submitted: nil)
          expect(@order).to be_invalid
        end
      end
    end
  end
end
