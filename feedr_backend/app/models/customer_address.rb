class CustomerAddress < ApplicationRecord
  belongs_to :user
  geocoded_by :address

  validates :address, presence: true, length: { minimum: 22 }
  after_save :set_default_address

  after_validation :geocode

  def update_default_address
    addresses = CustomerAddress.where(user: user).where(default_address: true).update(default_address: false)
    self.update(default_address: true)
  end

  private
  def set_default_address
    user_addresses = user.customer_addresses
    if user_addresses.size == 1 and !user_addresses.last.default_address
      user_addresses.last.update(default_address: true)
    end
  end
end
