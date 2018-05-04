class AddTypeToPodcast < ActiveRecord::Migration
  def change
  	add_column :podcasts, :type, :string, null: :false
  end
end
