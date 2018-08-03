class AddRankerIdIndexToRanks < ActiveRecord::Migration[5.2]
  def change
    add_index :ranks, :ranker_id
    add_index :ranks, :rankee_id
  end
end
