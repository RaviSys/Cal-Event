class CreateSpeakers < ActiveRecord::Migration[5.2]
  def change
    create_table :speakers do |t|
      t.string :name
      t.string :profile_image
      t.string :about
      t.string :organization
      t.string :city
      t.string :country
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
