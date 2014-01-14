class CreateGyms < ActiveRecord::Migration
  def change
    create_table :gyms do |t|
      t.string :name
      t.string :address
      t.string :cross_street
      t.string :phone_number

      t.timestamps
    end
  end
end
