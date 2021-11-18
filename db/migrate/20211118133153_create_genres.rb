class CreateGenres < ActiveRecord::Migration[6.1]
  def change
    create_table :genres do |t|
      t.string :title
      t.text :description
      t.index :title, unique: true
      t.timestamps
    end
  end
end
