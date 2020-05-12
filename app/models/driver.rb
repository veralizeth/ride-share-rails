class Driver < ApplicationRecord

  validates :name, presence: true
  validates :vin, presence: true

  has_many :trips,  dependent: :nullify

  def total_earnings

    return self.trips.sum { |trip| (trip.cost - 1.65 ) * 0.8 }

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
      total_rating / count 
    end
  end

end
