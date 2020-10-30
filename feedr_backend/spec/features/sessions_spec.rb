require 'rails_helper'

describe "the signin process", js: true do
  it "signs me in" do
    visit 'http://localhost:3000/login'
    sleep 3; byebug
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
