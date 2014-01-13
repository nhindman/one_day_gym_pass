class CreatePasses < ActiveRecord::Migration
  def change
    create_table :passes do |t|
      t.integer :user_id
      t.integer :gym_id
      t.integer :redemption_code
      t.string :timestamps

      t.timestamps
    end
  end
end
