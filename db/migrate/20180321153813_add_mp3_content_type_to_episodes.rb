class AddMp3ContentTypeToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :mp3_content_type, :string
  end
end
