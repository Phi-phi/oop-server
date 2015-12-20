class CreateApis < ActiveRecord::Migration
  def change
    create_table :apis do |t|#, id: false do |t|
      t.string :name, null: false
      t.text :description, null:false
      t.string :resource_url, null:false

      t.timestamps null: false
    end
  end
end
