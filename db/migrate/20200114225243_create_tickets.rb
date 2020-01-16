class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.string :ticket_type
      t.decimal :price
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :showing, null: false, foreign_key: true

      t.timestamps
    end
  end
end
