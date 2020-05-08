class PassengersController < ApplicationController
  def index # Fleching out our index action.
    @passengers = Passenger.all
  end


  def show
    passenger_id = params[:id]
    @passenger = Passenger.find_by(id: passenger_id)
    if @passenger.nil?
      head :not_found
      return
    end
  end

  def new
    @passenger = Passenger.new
  end
end
