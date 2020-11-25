class CustomerAddress < ApplicationRecord
  belongs_to :user
  geocoded_by :address

  validates :address, presence: true, length: { minimum: 22 }
  after_save :set_default_address

  after_validation :geocode

  private
  def set_default_address
    customer_addresses = CustomerAddress.last.user.customer_addresses
    if customer_addresses.size == 1 and !customer_addresses.last.default_address
      CustomerAddress.last.update(default_address: true)
    end
  end
end
