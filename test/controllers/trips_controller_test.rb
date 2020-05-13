require "test_helper"

describe TripsController do
 
  before do 
    @passenger = Passenger.create(name: "haben", phone_num:"22293094")
    @driver = Driver.create(name: "Vera", vin: "AAVDSRE", available: true)

  end

  let (:trip) {
    Trip.create driver: @driver,  passenger: @passenger, date:"Trip's date", cost: 60, rating: 5
  }

  describe "show" do
    it "can get a valid trip" do
      # Act
      get trip_path(trip.id)
    
      # Assert
      must_respond_with :success
    end
  
    it "will display not found for an invalid trip" do
      # Act
      get trip_path(0)
    
      # Assert
      must_respond_with :not_found
    end
  end

 
  describe "create" do
    before do 
      @passenger = Passenger.create(name: "haben", phone_num:"22293094")
      # @driver = Driver.create(name: "Vera", vin: "AAVDSRE", available: true)
      @driver = @passenger.available_driver
      # puts @passenger.available_driver
    end
    it "can create a new trip" do
    
      # Arrange
      trip_hash = {
        trip: {
          driver: @passenger.available_driver,
          passenger: @passenger,
          date: Date.today,
          cost: 200,
          rating: 4,
        },
      }
      
      # Act-Assert
      expect {
        post trips_path, params: trip_hash
      }.must_change "Trip.count", 1
      
      new_trip= Trip.find_by(id: trip_hash[:trip][:id])
      expect(new_trip.id).must_equal trip_hash[:trip][:id]

      
      must_respond_with :redirect
      must_redirect_to trip_path(new_trip.id)
    end
  end

  describe "edit" do
    it "can get the edit page for trip" do
     
      # Arrange
      get edit_trip_path(trip.id)
      # Act-Assert
      must_respond_with :success
    end
    it "will respond with redirect when attempting to edit a nonexistant trip" do
      
      get edit_trip_path(-10)
      # Assert
      must_respond_with :not_found
    end
  end


  describe "update" do
      
    let (:new_trip_hash) {
      {
        trip: {
          driver: @passenger.available_driver,
          passenger: @passenger,
          date: Date.today,
          cost: 200,
          rating: 4,
        }
      }
    }
    it "will update a model with a valid post request" do
    
      id = trip.id
      expect {
        patch trip_path(id), params: new_trip_hash
      }.wont_change "Trip.count"

      must_respond_with :redirect

      trip = Trip.find_by(id: id)
      expect(trip.id).must_equal trip.id
      # expect(passenger.phone_num).must_equal new_passenger_hash[:passenger][:phone_num]
    end

    it "will respond with not_found for invalid ids" do
      id = -1

      expect {
        patch trip_path(id), params: new_trip_hash
      }.wont_change "Trip.count"

      must_respond_with :not_found
    end

    it "will not update if the params are invalid" do
      id = trip.id
      new_trip_hash[:trip][:cost] = nil
      trip = Trip.find_by(id: id)
      expect {
        patch trip_path(trip.id), params: new_trip_hash
      }.wont_change "Trip.count"

      trip.reload
      must_respond_with :bad_request
      expect(trip.id).wont_be_nil
    end
  end



  describe "destroy" do
    it "can delete a trip" do
    
      # Arrange
      delete trip_path(trip.id)
      # Act-Assert
      must_respond_with :redirect
    end
    it "will respond with redirect when attempting to delete a nonexistant trip" do
      
      delete trip_path(-10)
      # Assert
      must_respond_with :not_found
    end
  end
end

