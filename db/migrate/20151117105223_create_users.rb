class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :macaddr,          null:false
      t.integer :access_point_id, null:false

      t.timestamps null: false
    end
  end
end
