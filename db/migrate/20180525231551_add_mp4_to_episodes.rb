class AddMp4ToEpisodes < ActiveRecord::Migration
  def change
  	add_column :episodes, :mp4, :string
  	add_column :episodes, :mp4_file_name, :string
  	add_column :episodes, :mp4_file_size, :integer
  	add_column :episodes, :mp4_content_type, :string
  end
end
