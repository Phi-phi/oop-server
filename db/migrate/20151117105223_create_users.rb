class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password#,         null:false # will be auto-generated
      t.string :secret#,           null:false # don't let user insert this
      t.string :keyword
      t.string :salt
      t.string :macaddr,          null:false
      t.integer :access_point_id, null:false

      t.timestamps null: false
    end
  end
end

# TODO :password :secret :keyword :salt のコメントアウトは本番は取ってください！試験がめんどいからつけてるだけです