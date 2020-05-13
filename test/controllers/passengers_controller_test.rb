require "test_helper"

describe PassengersController do
  let (:passenger) {
    Passenger.create name: "passenger name", phone_num: "phone number"
  }

  describe "index" do
    it "can get the index path" do
      # Act
      get passengers_path

      # Assert
      must_respond_with :success
    end

    it "can get the root path" do
      # Act
      get root_path

      # Assert
      must_respond_with :success
    end
  end

  describe "show" do
    it "can get a valid passenger" do
      # Act
      get passenger_path(passenger.id)

      # Assert
      must_respond_with :success
    end

    it "will display not found for an invalid passenger" do
      # Act
      get passenger_path(0)

      # Assert
      must_respond_with :not_found
    end
  end

  describe "new" do
    it "can get the new passenger page" do
      # Act
      get new_passenger_path

      # Assert
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new passenger" do

      # Arrange
      passenger_hash = {
        passenger: {
          name: "new passenger",
          phone_num: "phone number",
        },
      }

      # Act-Assert
      expect {
        post passengers_path, params: passenger_hash
      }.must_change "Passenger.count", 1

      new_passenger = Passenger.find_by(name: passenger_hash[:passenger][:name])
      expect(new_passenger.phone_num).must_equal passenger_hash[:passenger][:phone_num]

      must_respond_with :redirect
      must_redirect_to passenger_path(new_passenger.id)
    end
  end

  describe "edit" do
    it "can get the edit page for passenger" do

      # Arrange
      get edit_passenger_path(passenger.id)

      # Act-Assert
      must_respond_with :success
    end

    it "will respond with redirect when attempting to edit a nonexistant passenger" do
      # Arrange
      get edit_passenger_path(-10)

      # Assert
      must_respond_with :not_found
    end
  end

  describe "update" do
    let (:new_passenger_hash) {
      {
        passenger: {
          name: "Passenger Name",
          phone_num: "Phone Number",
        },
      }
    }
    it "will update a model with a valid post request" do
      id = passenger.id
      expect {
        patch passenger_path(id), params: new_passenger_hash
      }.wont_change "Passenger.count"

      must_respond_with :redirect

      passenger = Passenger.find_by(id: id)
      expect(passenger.name).must_equal passenger.name
      expect(passenger.phone_num).must_equal new_passenger_hash[:passenger][:phone_num]
    end

    it "will respond with not_found for invalid ids" do
      id = -1

      expect {
        patch passenger_path(id), params: new_passenger_hash
      }.wont_change "Passenger.count"

      must_respond_with :not_found
    end

    it "will not update if the params are invalid" do
      id = passenger.id
      new_passenger_hash[:passenger][:name] = nil
      passenger = Passenger.find_by(id: id)
      expect {
        patch passenger_path(passenger.id), params: new_passenger_hash
      }.wont_change "Passenger.count"

      passenger.reload
      must_respond_with :bad_request
      expect(passenger.name).wont_be_nil
    end
  end

  describe "destroy" do
    it "can delete a passenger" do
      passenger = Passenger.create name: "Vera Wang", phone_num: "1234567"
      # Assert
      expect {
        delete passenger_path(passenger.id)
      }.must_differ "Passenger.count", -1

      must_redirect_to passengers_path
    end
    it "will respond with redirect when attempting to delete a nonexistant passenger" do
      expect {
        delete passenger_path(-1)
      }.must_differ "Passenger.count", 0

      # Act-Assert
      must_respond_with :not_found
    end
  end
end
