class AddUsernameIndexToUser < ActiveRecord::Migration
  def change
  	add_index :users, [:username, :email]
  end
end
