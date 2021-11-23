class AddEmailConfirmationToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :email_confirmation, :string
    add_column :users, :email_confirmation_sent_at, :datetime
    add_column :users, :email_confirmed, :boolean, default: false
    add_index :users, :email_confirmation, unique: true
  end
end
