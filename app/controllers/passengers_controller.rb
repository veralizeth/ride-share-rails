class PassengersController < ApplicationController
  def index # Fleshing out our index action.
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


  def create
    @passenger = Passenger.new(passenger_params)
    
    if @passenger.save 
      redirect_to passenger_path(@passenger.id) 
      return
    else 
      render :new 
    end
  end


  def edit
    @passenger = Passenger.find_by(id: params[:id])

    if @passenger.nil?
      head :not_found
      return
    end
  end


  def update
    @passenger = Passenger.find_by(id: params[:id])
    if @passenger.nil?
      head :not_found
      return
    elsif @passenger.update(passenger_params)
      redirect_to passenger_path(@passenger.id) 
      return
    else 
      render :edit 
      return
    end
  end


  def destroy
    passenger_id = params[:id]
    passenger = Passenger.find_by(id: passenger_id)

    if passenger.nil?
      head :not_found
      return
    end

  passenger.destroy
  redirect_to trips_path
 
  end


  private

  def passenger_params
    return params.require(:passenger).permit(:name, :phone_num)
  end

end


