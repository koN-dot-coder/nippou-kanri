class CreateDailyReports < ActiveRecord::Migration[7.2]
  def change
    create_table :daily_reports do |t|
      t.references :user, null: false, foreign_key: true
      t.date :report_date, null: false
      t.text :done
      t.text :trouble
      t.text :plan
      t.integer :condition
      t.integer :status, null: false, default: 0
      t.boolean :needs_attention, null: false, default: false
      t.datetime :submitted_at

      t.timestamps
    end
    add_index :daily_reports, [ :user_id, :report_date ], unique: true
  end
end
