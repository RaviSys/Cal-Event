class AddFieldsToGuests < ActiveRecord::Migration[5.2]
  def change
    add_column :guests, :name, :string
    add_column :guests, :is_organizer, :boolean
  end
end
