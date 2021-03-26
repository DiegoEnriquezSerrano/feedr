class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist
  geocoded_by :caterer_business_full_address, if: -> (u) { u.caterer_user == true }

  has_many :meals, dependent: :delete_all
  has_many :orders
  has_many :customer_addresses

  validates :first_name, presence: true, length: { minimum: 2, maximum: 25 }
  validates :last_name, presence: true, length: { minimum: 2, maximum: 35 }
  validates :caterer_user, inclusion: { in: [ true, false] }
  validates :caterer_business_name, presence: true, if: -> (u) { u.caterer_user == true }
  validates :caterer_business_address, presence: true, if: -> (u) { u.caterer_user == true }
  validates :caterer_business_city, presence: true, if: -> (u) { u.caterer_user == true }
  validates :caterer_business_state, presence: true, if: -> (u) { u.caterer_user == true }
  validates :zip_code, presence: true, if: -> (u) { u.caterer_user == true }
  validates :caterer_business_cover_image, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }

  after_validation :geocode, if: -> (u) { u.caterer_business_full_address.present? and u.address_changed? }

  def caterer_business_full_address
    if caterer_user == true
      [caterer_business_address, caterer_business_city, zip_code, caterer_business_state].compact.join(", ")
    end
  end

  def address_changed?
    if caterer_user == true
      (caterer_business_address_changed? || caterer_business_city_changed? || zip_code_changed? || caterer_business_state_changed?)
    end
  end
end
