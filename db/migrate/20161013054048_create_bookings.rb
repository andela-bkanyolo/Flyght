class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.string :reference
      t.references :flight, index: true, foreign_key: true

      t.timestamps
    end
  end
end
