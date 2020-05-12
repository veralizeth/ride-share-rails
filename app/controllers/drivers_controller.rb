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

  def update
    @driver = Driver.find_by(id: params[:id])
    if @driver.nil?
      head :not_found
      return
    elsif @driver.update(driver_params)
      redirect_to driver_path(@driver.id) # go to the index so we can see the driver in the list
      return
    else # save failed :(
      render :edit # show the new driver form view again
      return
    end
  end

  def edit
    @driver = Driver.find_by(id: params[:id])

    if @driver.nil?
      head :not_found
      return
    end
  end

  def destroy
    driver = Driver.find_by(id: params[:id])
    if driver.nil?
      head :not_found
      return
    else
      driver.destroy
      redirect_to drivers_path
    end
  end

  def new
    @driver = Driver.new
  end

  def create
    @driver = Driver.new(driver_params)

    if @driver.save
      redirect_to driver_path(@driver.id)# Send them to the '/trips' path
    else
    
      render :new
    
    end
  end

  private

  # Method that does params requare, driver sub hash, before submit it.
  def driver_params
    return params.require(:driver).permit(:name, :vin, :available)
  end
end
