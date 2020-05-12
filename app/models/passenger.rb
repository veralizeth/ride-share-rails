class Passenger < ApplicationRecord
  validates :name, presence: true
  validates :phone_num, presence: true
  has_many :trips, dependent: :nullify

  def available_driver
    available_driver = Driver.where(available: true)
    first_driver = available_driver.first
    if first_driver
      return first_driver
    else
      return nil
    end
  end

  # See the total amount the passenger has been charged
  def total_charged
   return self.trips.sum(&:cost)
  end
end