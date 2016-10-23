class CreateFlights < ActiveRecord::Migration[5.0]
  def change
    create_table :flights do |t|
      t.string :origin
      t.string :destination
      t.datetime :departure
      t.float :distance
      t.float :duration
      t.float :price
      t.references :airline, index: true, foreign_key: true

      t.timestamps
    end
  end
end
