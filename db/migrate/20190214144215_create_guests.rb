class CreateGuests < ActiveRecord::Migration[5.2]
  def change
    create_table :guests do |t|
      t.string :email
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
