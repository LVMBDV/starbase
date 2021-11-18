class CreateJoinTableRoles < ActiveRecord::Migration[6.1]
  def change
    create_join_table :movies, :stars do |t|
      t.index :movie_id
      t.index :star_id
      t.index [:movie_id, :star_id]
      t.string :title, null: false
      t.boolean :is_acting, default: true
    end
  end
end
