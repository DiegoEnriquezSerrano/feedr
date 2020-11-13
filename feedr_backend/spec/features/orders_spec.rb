require 'rails_helper'

describe "creating a new order", js: true do
  fixtures :users, :meals

  before(:each) {
    User.create(
      first_name: 'Johnny',
      last_name: 'Bravo',
      email: 'jbravo@cn.com',
      password: 'password',
      password_confirmation: 'password',
      caterer_user: false
    )
  }

  context 'without first logging in' do
    it 'cannot find an order widget' do
      visit 'http://localhost:3050/caterers/1'
      expect(page).to_not have_selector '.order-widget'
    end
  end

  scenario 'authenticated user adding a meal to their order and submitting it' do
    visit 'http://localhost:3050/login'
    within(".authentication-form") do
      fill_in 'email', with: 'jbravo@cn.com'
      fill_in 'password', with: 'password'
    end
    Capybara.page.first('button[type="submit"]').click
    visit 'http://localhost:3050/caterers/1'
    expect(page).to have_selector '.order-widget'
    expect(page).to have_button('Add to order', disabled: true)
    click_button('+')
    click_button('Add to order')
    visit 'http://localhost:3050/order/new'
    expect(page).to_not have_selector '.empty-order-message'
    click_button('Submit')
    expect(page).to have_selector '.caterers'
  end
end
