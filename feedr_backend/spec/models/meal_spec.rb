require 'rails_helper'

describe Meal do
  fixtures :users, :meals
  
  context 'submitting a meal' do
    before(:each) { 
      @user = User.find(users(:caterer).id)
      @meal = Meal.find(meals(:jackfruit_carnitas).id)
    }

    it 'requires meal attributes to be present' do
      @meal2 = Meal.new(user_id: @user.id)
      expect(@meal2).to be_invalid
    end

    it "requires meal price to be positive" do
      @meal.price_minimum = -1
      expect(@meal).to be_invalid
      assert_equal ["must be greater than or equal to 0.01"], @meal.errors[:price_minimum]
  
      @meal.price_minimum = 0
      expect(@meal).to be_invalid
      assert_equal ["must be greater than or equal to 0.01"], @meal.errors[:price_minimum]
  
      @meal.price_minimum = 0.01
      expect(@meal).to be_valid
    end

    it "requires meal serving size to be at least 1" do
      @meal.servings_minimum = -1
      expect(@meal).to be_invalid
      assert_equal ["must be greater than or equal to 1"], @meal.errors[:servings_minimum]

      @meal.servings_minimum = 0
      expect(@meal).to be_invalid
      assert_equal ["must be greater than or equal to 1"], @meal.errors[:servings_minimum]

      @meal.servings_minimum = 1
      expect(@meal).to be_valid
    end

    it "requires meal to have a unique name" do
      @meal = Meal.new(name: 'Sunday Morning Jackfruit Carnitas',
                       description: "So good you won't know what to do",
                       ingredients: "Slow Roasted Jackfruit, cilantro, onion, lime, salsa",
                       servings_minimum: 5,
                       price_minimum: 40.00,
                       cover_image: 'img1.jpg',
                       user_id: @user.id)
      expect(@meal).to be_invalid
      assert_equal ["has already been taken"], @meal.errors[:name]
    end

    it "expects meal to be valid" do
      expect(@meal).to be_valid
    end
  end
end
