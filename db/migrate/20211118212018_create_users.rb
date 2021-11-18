class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email_address
      t.string :password_digest
      t.string :password_reset
      t.index :email_address, unique: true
      t.index :password_reset, unique: true
      t.timestamps
    end
  end
end
