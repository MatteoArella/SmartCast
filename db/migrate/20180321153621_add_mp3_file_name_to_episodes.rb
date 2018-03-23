class AddMp3FileNameToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :mp3_file_name, :string
  end
end
