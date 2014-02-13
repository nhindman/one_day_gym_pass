class AddSnippetTextColumnToGymsTable < ActiveRecord::Migration
  def change
    add_column :gyms, :snippet_text, :string
  end
end
