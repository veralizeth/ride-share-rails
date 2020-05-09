class TripsController < ApplicationController
  def index # Fleshing out our index action.

    @trips = Trip.all
    
  end
end
