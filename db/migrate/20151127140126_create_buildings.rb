class CreateBuildings < ActiveRecord::Migration
  def change
    create_table :buildings do |t|
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
