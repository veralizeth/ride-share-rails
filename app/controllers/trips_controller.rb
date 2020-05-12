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


  # def new
  #   @trip = Trip.new
  # end



  def create
    @trip = Trip.new(trip_params)
    
    if @trip.save 
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
      render :edit 
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


  private

  def trip_params
    return params.require(:trips).permit(:available_driver, :passenger_id, :cost, :rating)
  end

end


