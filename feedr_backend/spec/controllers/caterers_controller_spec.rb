require 'rails_helper'

RSpec.describe 'Caterers', type: :request do
  fixtures :users, :meals

  describe 'GET /caterers' do
    before(:example) { get caterers_path }
    it "is a success" do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /caterers#show', type: :request do
    before(:each) {
      caterer = User.create( first_name: 'Diego',
                             last_name: 'Enriquez-Serrano',
                             email: 'diegoen@provi.com',
                             caterer_user: true,
                             caterer_business_name: 'Carnitas Round the Corner',
                             caterer_business_address: '1622 N Central Park Ave',
                             caterer_business_city: 'Chicago',
                             caterer_business_state: 'IL',
                             zip_code: 60647)
    }
    context 'for an existing user' do
      it "is a success" do
        @caterer = User.where(caterer_user: true).last
        get caterer_path(@caterer)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'for a non existing user' do
      it "is not a success" do
        id = User.where(caterer_user: true).last.id
        get caterer_path(id + 100)
        expect(response).to have_http_status(:not_found)
      end
    end
  end
  # describe 'GET /search' do
  #   before(:example) {
  #     my_cookies = ActionDispatch::Request.new(Rails.application.env_config.deep_dup).cookie_jar
  #     my_cookies.signed[:jwt] = ENV['CUSTOMER_JWT']
  #     cookies[:jwt] = my_cookies[:jwt]
  #     get search_path
  #   }
  #   it "is a success" do
  #     expect(response).to have_http_status(:ok)
  #   end
  # end
end