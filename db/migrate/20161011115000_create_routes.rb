class CreateRoutes < ActiveRecord::Migration[5.0]
  def change
    create_table :routes do |t|
      t.string :origin
      t.string :destination
      t.references :airline, index: true, foreign_key: true

      t.timestamps
    end
  end
end
