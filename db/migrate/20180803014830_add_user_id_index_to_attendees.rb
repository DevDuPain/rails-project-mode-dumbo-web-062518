class AddUserIdIndexToAttendees < ActiveRecord::Migration[5.2]
  def change
    add_index :attendees, :user_id
    add_index :attendees, :event_id
  end
end
