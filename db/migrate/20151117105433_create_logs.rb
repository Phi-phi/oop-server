class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.text :body
      t.timestamp :log_date

      t.timestamps null: false
    end
  end
end
