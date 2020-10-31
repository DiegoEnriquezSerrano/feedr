require 'rails_helper'

describe "logging in an existing user", js: true do
  before(:example) {
    User.create(
      first_name: 'Johnny',
      last_name: 'Bravo',
      email: 'jbravo@cn.com',
      password: 'password',
      password_confirmation: 'password',
      caterer_user: false
    )
  }
  it "fills out the login form and submits" do
    visit 'http://localhost:3000/login'
    within(".authentication-form") do
      fill_in 'email', with: 'jbravo@cn.com'
      fill_in 'password', with: 'password'
    end 
    old_path = Capybara.page.current_url
    Capybara.page.first('button[type="submit"]').click
    sleep 0.1
    expect(page).to have_selector '.caterers'
  end
end
