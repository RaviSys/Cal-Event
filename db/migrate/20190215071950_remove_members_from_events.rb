class RemoveMembersFromEvents < ActiveRecord::Migration[5.2]
  def change
    remove_column :events, :members, :string
  end
end
