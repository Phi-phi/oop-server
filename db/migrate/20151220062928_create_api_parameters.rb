class CreateApiParameters < ActiveRecord::Migration
  def change
    create_table :api_parameters do |t|
      t.string :name, null: false
      t.boolean :optional, null: false
      t.text :description
      t.string :example_value
      t.string :api_name, null:false

      t.timestamps null: false
    end
  end
end
