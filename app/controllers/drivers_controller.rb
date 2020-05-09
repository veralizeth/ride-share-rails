class DriversController < ApplicationController
  def index # Fleching out our index action.
    @drivers = Driver.all
  end

  def show
    # Raise an exception.
    # Be aware that any string will be converted to 0
    driver_id = params[:id].to_i
    # It needs to handle this exception.
    @driver = Driver.find_by(id: driver_id)

    puts @driver

    if @driver.nil?
      head :not_found
      return
    end
  end
end
