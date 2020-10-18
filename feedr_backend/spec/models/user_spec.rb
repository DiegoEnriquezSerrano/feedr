require 'rails_helper'

describe User do
  context 'validates customer user' do
    it 'must have business info' do
      user = User.create(first_name: "Johnny",
                      last_name: "Bravo",
                      email: "jbravo@cn.com",
                      caterer_user: false,
                      password: 'password')
      expect(user).to be_valid
    end
  end

  context 'validates caterer user' do
    it 'must have business info' do
      user = User.create(first_name: "Johnny",
                      last_name: "Bravo",
                      email: "jbravo@cn.com",
                      caterer_user: true,
                      password: 'password',
                      caterer_business_name: 'carnitas round the corner',
                      caterer_business_address: '123 fake st',
                      caterer_business_city: 'chicago',
                      caterer_business_state: 'il',
                      zip_code: 60647)
      expect(user).to be_valid
    end
  end
end