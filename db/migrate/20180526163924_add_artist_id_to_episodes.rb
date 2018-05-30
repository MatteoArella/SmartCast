class AddArtistIdToEpisodes < ActiveRecord::Migration
  def change
  	add_column :episodes, :artist_id, :integer
  end
end
