class ChangeTripsCostAndRatingType < ActiveRecord::Migration[6.0]
  def change
    change_column :trips, :cost, :integer, null: false, default: 0
    change_column :trips, :rating, :integer, null: false, default: 0
  end
end
