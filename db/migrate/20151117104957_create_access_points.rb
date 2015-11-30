class CreateAccessPoints < ActiveRecord::Migration
  def change
    create_table :access_points do |t|
      t.string :name
      t.string :macaddr,            null:false
      t.integer :classroom_id,      null:false

      t.timestamps null: false
    end
  end
end
