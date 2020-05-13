class TripsController < ApplicationController
  def index # Fleshing out our index action.
    @trips = Trip.all
  end

  def show
    trip_id = params[:id]

    @trip = Trip.find_by(id: trip_id)
    if @trip.nil?
    
      head :not_found
      return
    end
  end

  def create
    @passenger = Passenger.find_by(id: params[:passenger_id])
    @driver = @passenger.available_driver

    new_trip_info = { driver_id: @driver.id, passenger_id: @passenger.id, date: Date.today, cost: 100 }

    @trip = Trip.new(new_trip_info)

    if @trip.save
      @driver.available = false
      @driver.save

      redirect_to trip_path(@trip.id)
      
      return
    else
      render :new
    end
  end

  def edit
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      head :not_found
      return
    end
  end

  def update
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      head :not_found
      return
    elsif @trip.update(trip_params)
      redirect_to trip_path(@trip.id)
      return
    else
      render :edit, status: :bad_request
      return
    end
  end

  def destroy
    trip_id = params[:id]
    trip = Trip.find_by(id: trip_id)

    if trip.nil?
      head :not_found
      return
    end

    trip.destroy
    redirect_to trips_path
  end

  def rating
    @trips = Trip.where(rating: 0)

    if @trips.nil?
      head :not_found
      return
    end
  end

  private

  def trip_params
    return params.require(:trip).permit(:date, :rating, :cost, :driver_id, :passenger_id)
  end
end
