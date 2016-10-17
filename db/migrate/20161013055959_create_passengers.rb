class CreatePassengers < ActiveRecord::Migration[5.0]
  def change
    create_table :passengers do |t|
      t.string :name
      t.integer :age
      t.string :passport
      t.string :phone
      t.references :booking, index: true

      t.timestamps
    end
  end
end
