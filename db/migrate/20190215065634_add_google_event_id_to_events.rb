class AddGoogleEventIdToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :google_event_id, :string
  end
end
