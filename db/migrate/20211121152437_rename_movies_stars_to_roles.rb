class RenameMoviesStarsToRoles < ActiveRecord::Migration[6.1]
  def change
    rename_table :movies_stars, :roles
  end
end
