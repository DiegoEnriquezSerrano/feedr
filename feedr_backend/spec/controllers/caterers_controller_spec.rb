require 'rails_helper'

RSpec.describe 'Caterers', type: :request do
  fixtures :users
  describe 'GET /caterers' do
    before(:example) { get caterers_path }
    it "is a success" do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /search' do
    before(:example) {
      my_cookies = ActionDispatch::Request.new(Rails.application.env_config.deep_dup).cookie_jar
      my_cookies.signed[:jwt] = 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.8omL6PuZyC-JKtutfNN9UP4Ohvy-AlcBKDf9p36R5Uk'
      cookies[:jwt] = my_cookies[:jwt]
      get search_path
    }
    it "is a success" do
      expect(response).to have_http_status(:ok)
    end
  end
end