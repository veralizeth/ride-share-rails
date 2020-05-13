require "test_helper"

describe DriversController do
  # Note: If any of these tests have names that conflict with either the requirements or your team's decisions, feel empowered to change the test names. For example, if a given test name says "responds with 404" but your team's decision is to respond with redirect, please change the test name.

  let (:driver) {
    Driver.create name: "driver name", vin: "vin number", available: true
  }
  describe "index" do
    it "responds with success when there are many drivers saved" do
      # Arrange
      # Ensure that there is at least one Driver saved
      # Act
      get drivers_path

      # Assert
      must_respond_with :success
    end

    it "can get the root path" do
      # Act
      get root_path

      # Assert
      must_respond_with :success
    end

    it "responds with success when there are no drivers saved" do
      # Arrange
      # Ensure that there are zero drivers saved

      # Act

      # Assert

    end
  end

  describe "show" do
    it "responds with success when showing an existing valid driver" do
      # Arrange
      # Ensure that there is a driver saved
      get driver_path(driver.id)
      # Act

      # Assert
      must_respond_with :success
    end

    it "responds with 404 with an invalid driver id" do
      # Arrange
      # Ensure that there is an id that points to no driver
      get driver_path(-10)
      # Act

      # Assert
      must_respond_with :not_found
    end
  end

  describe "new" do
    it "responds with success" do
      get new_driver_path
      # Assert
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new driver with valid information accurately, and redirect" do
      # Arrange
      # Set up the form data

      driver_hash = {
        driver: {
          name: "new driver",
          vin: "phone number",
          available: true,
        },
      }

      # Act-Assert
      # Ensure that there is a change of 1 in Driver.count
      expect {
        post drivers_path, params: driver_hash
      }.must_change "Driver.count", 1
      # Assert
      # Find the newly created Driver, and check that all its attributes match what was given in the form data
      new_driver = Driver.find_by(name: driver_hash[:driver][:name])
      expect(new_driver.vin).must_equal driver_hash[:driver][:vin]
      # Check that the controller redirected the user
      must_respond_with :redirect
      must_redirect_to driver_path(new_driver.id)
    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Set up the form data so that it violates Driver validations

      # Act-Assert
      # Ensure that there is no change in Driver.count

      # Assert
      # Check that the controller redirects

      # no_name = driver[:driver][:name] = nil
      # no_vin = driver[:driver][:vin] = nil

      # # Assert
      # # Check that the controller redirects
      # expect { post drivers_path, params: no_name }.must_differ "Driver.count", 0
      # expect { post drivers_path, params: no_vin }.must_differ "Driver.count", 0
      # must_respond_with :redirect
    end
  end

  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid driver" do
      # Arrange
      # Ensure there is an existing driver saved
      get edit_driver_path(driver.id)
      # Act-Assert
      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing driver" do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      get edit_driver_path(-10)
      # Assert
      must_respond_with :not_found
    end
  end

  describe "update" do
    let (:new_driver_hash) {
      {
        driver: {
          name: "driver Name",
          vin: "VDSDD",
          available: true,
        },
      }
    }
    it "will update a model with a valid post request" do
      id = driver.id
      expect {
        patch driver_path(id), params: new_driver_hash
      }.wont_change "Driver.count"

      must_respond_with :redirect

      driver = Driver.find_by(id: id)
      expect(driver.name).must_equal driver.name
      expect(driver.vin).must_equal new_driver_hash[:driver][:vin]
    end

    it "will respond with not_found for invalid ids" do
      id = -1

      expect {
        patch driver_path(id), params: new_driver_hash
      }.wont_change "Driver.count"

      must_respond_with :not_found
    end

    it "will not update if the params are invalid" do
      id = driver.id
      new_driver_hash[:driver][:name] = nil
      passenger = Driver.find_by(id: id)
      expect {
        patch driver_path(driver.id), params: new_driver_hash
      }.wont_change "Driver.count"

      driver.reload
      must_respond_with :bad_request
      expect(driver.name).wont_be_nil
    end
  end

  describe "destroy" do
    it "destroys the driver instance in db when driver exists, then redirects" do

      # Ensure that there is a change of -1 in Driver.count
      driver = Driver.create name: "Vera Wang", vin: "ASCSF", available: true
      # Assert
      expect {
        delete driver_path(driver.id)
      }.must_differ "Driver.count", -1
      # Check that the controller redirects
      must_redirect_to drivers_path
    end

    it "does not change the db when the driver does not exist, then responds with " do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      expect {
        delete driver_path(-1)
      }.must_differ "Driver.count", 0
      # Act-Assert
      # Ensure that there is no change in Driver.count
      must_respond_with :not_found
      # Assert
      # Check that the controller responds or redirects with whatever your group decides

    end
  end
end
