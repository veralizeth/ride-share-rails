class DriversController < ApplicationController
  def index # Fleching out our index action.
    @drivers = Driver.all
  end
end
