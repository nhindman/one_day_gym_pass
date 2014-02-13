class AddUrlColumnToGymsTable < ActiveRecord::Migration
  def change
    add_column :gyms, :url, :string
  end
end
