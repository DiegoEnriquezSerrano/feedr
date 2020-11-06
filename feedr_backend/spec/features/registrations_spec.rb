require 'rails_helper'

describe "signing up a new user", js: true do
  it "fills out the customer form and signs up" do
    visit 'http://localhost:3000/signup'
    within(".authentication-form") do
      fill_in 'first_name', with: 'Johnny'
      fill_in 'last_name', with: 'Bravo'
      fill_in 'email', with: 'jbravo@cn.com'
      fill_in 'password', with: 'password'
      fill_in 'password_confirmation', with: 'password'
    end
    Capybara.page.first('button[type="submit"]').click
    sleep 0.1
    expect(page).to have_selector '.caterers'
  end
end
