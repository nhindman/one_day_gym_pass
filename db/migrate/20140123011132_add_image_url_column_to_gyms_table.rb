class AddImageUrlColumnToGymsTable < ActiveRecord::Migration
  def change
    add_column :gyms, :image_url, :string
  end
end
