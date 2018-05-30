class AddArtistIdToEpisodes < ActiveRecord::Migration
  def change
  	add_coloumn :episodes, :artist_id, :integer
  end
end
