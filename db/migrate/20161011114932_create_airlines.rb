class CreateAirlines < ActiveRecord::Migration[5.0]
  def change
    create_table :airlines do |t|
      t.string :code
      t.string :name
      t.string :country

      t.timestamps
    end
  end
end
