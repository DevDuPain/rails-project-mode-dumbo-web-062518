class AddUserIdIndexToAvailabilities < ActiveRecord::Migration[5.2]
  def change
    add_index :availabilities, :user_id
  end
end
