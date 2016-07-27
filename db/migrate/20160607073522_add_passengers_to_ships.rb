class AddPassengersToShips < ActiveRecord::Migration
  def change
    add_column :ships, :passengers, :integer
  end
end
