class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  validates :first_name, presence: true, length: { minimum: 2, maximum: 25 }
  validates :last_name, presence: true, length: { minimum: 2, maximum: 35 }
  validates :caterer_user, inclusion: { in: [ true, false] }

  has_many :meals, dependent: :delete_all

  validates :caterer_business_name, presence: true, if: -> (u) { u.caterer_user == true }
  validates :caterer_business_address, presence: true, if: -> (u) { u.caterer_user == true }
  validates :caterer_business_city, presence: true, if: -> (u) { u.caterer_user == true }
  validates :caterer_business_state, presence: true, if: -> (u) { u.caterer_user == true }
  validates :zip_code, presence: true, if: -> (u) { u.caterer_user == true }
  validates :caterer_business_cover_image, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
}
end
