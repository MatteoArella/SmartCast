class AddMp3ToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :mp3, :string
  end
end
