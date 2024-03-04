class CreateShipAreas < ActiveRecord::Migration[7.0]
  def change
    create_table :ship_areas do |t|

      t.timestamps
    end
  end
end
