class AddVenueToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :venue, :string
    add_column :events, :city, :string
    add_column :events, :state, :string
    add_column :events, :country, :string
    add_column :events, :latitude, :float
    add_column :events, :longitude, :float
  end
end
