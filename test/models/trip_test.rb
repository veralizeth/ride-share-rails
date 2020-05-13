require "test_helper"

describe Trip do
  before do
    Passenger.create(name: "Vera Wang", phone_num: "123-344-3234")
    Driver.create(name: "Haben", vin: "QWE-DFAFS")
  end

  let (:new_trip_hash) {
    Trip.new(passenger_id: Passenger.all[0].id,
             driver_id: Driver.all[0].id,
             date: Date.today,
             cost: 100)
  }
  it "can be instantiated" do
    expect(new_trip_hash.valid?).must_equal true
    # Your code here
  end

  it "will have the required fields" do
    # Your code here

    new_trip_hash.save
    trip = Trip.first

    [:passenger_id, :driver_id, :date, :cost, :rating].each do |field|
      expect(trip).must_respond_to field
    end
  end

  describe "relationships" do
    # Your tests go here
    
  end

  describe "validations" do
    # Your tests go here
  end

  # Tests for methods you create should go here
  describe "custom methods" do
    # Your tests here
  end
end
