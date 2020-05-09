class CreateForeignKeyTrips < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :trips, :drivers, column: :driver_id
    add_foreign_key :trips, :passengers, column: :passenger_id
  end
end
