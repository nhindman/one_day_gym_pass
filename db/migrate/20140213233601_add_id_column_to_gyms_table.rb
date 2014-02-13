class AddIdColumnToGymsTable < ActiveRecord::Migration
  def change
    add_column :gyms, :business_id, :string
  end
end
