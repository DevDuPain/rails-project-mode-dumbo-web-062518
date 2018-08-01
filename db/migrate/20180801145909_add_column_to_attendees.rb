class AddColumnToAttendees < ActiveRecord::Migration[5.2]
  def change
    add_column :attendees, :hidden, :boolean, :default => false
  end
end
