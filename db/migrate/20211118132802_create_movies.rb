class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :original_title
      t.string :description
      t.date :release_date
      t.index [:original_title, :release_date], unique: true
      t.timestamps
    end
  end
end
