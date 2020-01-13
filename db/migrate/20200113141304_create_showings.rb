class CreateShowings < ActiveRecord::Migration[6.0]
  def change
    create_table :showings do |t|
      t.date :show_date
      t.integer :start_hour
      t.belongs_to :movie, null: false, foreign_key: true

      t.timestamps
    end
  end
end
