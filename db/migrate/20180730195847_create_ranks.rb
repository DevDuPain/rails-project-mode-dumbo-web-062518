class CreateRanks < ActiveRecord::Migration[5.2]
  def change
    create_table :ranks do |t|
      t.integer :ranker_id
      t.integer :rankee_id
      t.integer :rank

      t.timestamps
    end
  end
end
