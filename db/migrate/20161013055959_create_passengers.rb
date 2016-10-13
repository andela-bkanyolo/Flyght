class CreatePassengers < ActiveRecord::Migration[5.0]
  def change
    create_table :passengers do |t|
      t.string :name
      t.integer :age
      t.string :passport
      t.references :booking, index: true, foreign_key: true

      t.timestamps
    end
  end
end
