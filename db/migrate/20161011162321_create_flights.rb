class CreateFlights < ActiveRecord::Migration[5.0]
  def change
    create_table :flights do |t|
      t.string :ref
      t.datetime :departure
      t.datetime :arrival
      t.float :price
      t.references :route, index: true, foreign_key: true

      t.timestamps
    end
  end
end
