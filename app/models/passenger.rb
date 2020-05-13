class Passenger < ApplicationRecord
  validates :name, presence: true
  validates :phone_num, presence: true
  has_many :trips, dependent: :nullify

  # See the total amount the passenger has been charged
  def total_charged
    return self.trips.sum(&:cost)
  end
end
