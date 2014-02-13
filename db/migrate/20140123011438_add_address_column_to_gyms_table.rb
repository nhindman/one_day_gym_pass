class AddAddressColumnToGymsTable < ActiveRecord::Migration
  def change
    add_column :gyms, :distance, :string
  end
end
