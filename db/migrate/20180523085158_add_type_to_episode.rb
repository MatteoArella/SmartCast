class AddTypeToEpisode < ActiveRecord::Migration
  def change
  	add_column :episodes, :type, :string, null: :false
  end
end
