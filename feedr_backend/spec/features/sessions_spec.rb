require 'rails_helper'

describe "the signin process", js: true do
  it "signs me up" do
    visit 'http://localhost:3000/signup'
    within(".authentication-form") do
      fill_in 'first_name', with: 'Johnny'
      fill_in 'last_name', with: 'Bravo'
      fill_in 'email', with: 'jbravo@cn.com'
      fill_in 'password', with: 'password'
      fill_in 'password_confirmation', with: 'password'
    end 
    old_path = Capybara.page.current_url
    Capybara.page.first('button[type="submit"]').click
    sleep 0.1
    expect(page).to have_selector '.caterers'
  end
end
