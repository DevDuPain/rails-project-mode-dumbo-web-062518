class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.integer :owner_id
      t.string :name
      t.string :description
      t.datetime :date
      t.string :location_id
      t.integer :required_rank

      t.timestamps
    end
  end
end
