class CreateStars < ActiveRecord::Migration[6.1]
  def change
    create_table :stars do |t|
      t.string :full_name
      t.text :biography
      t.timestamps
    end
  end
end
