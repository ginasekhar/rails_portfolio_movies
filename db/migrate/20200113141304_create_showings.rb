class CreateShowings < ActiveRecord::Migration[6.0]
  def change
    create_table :showings do |t|
      t.date :show_date
      t.string :show_time
      t.belongs_to :movie, null: false, foreign_key: true

      t.timestamps
    end
  end
end
