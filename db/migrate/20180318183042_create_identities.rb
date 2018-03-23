class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|

    	t.references :user, index: true
      t.string :provider
      t.string :uid
      t.string :username
      t.string :email
      t.string :avatar

      t.datetime :created_at
      t.datetime :updated_at
			
			t.timestamps null: false
    end
  end
end
