class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :description
      t.string :genre
      t.datetime :release_date
      t.string :rating

      t.timestamps
    end
  end
end
