class Trip < ApplicationRecord
  validates :date, :cost, :rating, presence: true

  belongs_to :driver
  belongs_to :passenger
end


