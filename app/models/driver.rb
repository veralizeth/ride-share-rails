class Driver < ApplicationRecord
  validates :name, presence: true
  validates :vin, presence: true

  has_many :trips, dependent: :nullify

  def self.available_driver
    available_driver = Driver.where(available: true)
    first_driver = available_driver.first
    if first_driver
      return first_driver
    else
      return nil
    end
  end

  def total_earnings
    return self.trips.sum { |trip| (trip.cost - 165) * 0.8 }
  end

  def average_rating
    total_rating = 0
    count = 0
    self.trips.each do |trip|
      if trip.rating
        total_rating += trip.rating
        count += 1
      end
    end

    if count == 0
      return 0
    else
      return (total_rating.to_f / count).round(2)
    end
  end
end
