class CreateClassrooms < ActiveRecord::Migration
  def change
    create_table :classrooms do |t|
      t.string :name,          null:false
      t.text :location

      t.timestamps null: false
    end
  end
end
