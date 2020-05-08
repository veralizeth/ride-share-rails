class TripsController < ApplicationController
  def index # Fleching out our index action.
    @trips = Trip.all
  end
end
