class PassengersController < ApplicationController
  def index # Fleching out our index action.
    @passengers = Passenger.all
  end
end
