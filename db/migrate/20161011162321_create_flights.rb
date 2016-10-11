class CreateFlights < ActiveRecord::Migration[5.0]
  def change
    create_table :flights do |t|
      t.integer :number
      t.datetime :departure
      t.datetime :arrival
      t.references :airline, index: true, foreign_key: true
      t.references :route, index: true, foreign_key: true

      t.timestamps
    end
  end
end
