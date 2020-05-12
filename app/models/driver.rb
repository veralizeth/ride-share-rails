class Driver < ApplicationRecord
  has_many :trips,  dependent: :nullify

  def available_driver
    available_driver = self.drivers.where(available: true)
    first_driver = available_driver.first
    if first_driver
      return first_driver.name
    else
      return nil
    end
  end

end
