class CreateShipMethods < ActiveRecord::Migration[7.0]
  def change
    create_table :ship_methods do |t|

      t.timestamps
    end
  end
end
