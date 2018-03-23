class AddMp3FileSizeToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :mp3_file_size, :integer
  end
end
