class CreateVideoPodcasts < ActiveRecord::Migration
  def change
    create_table :video_podcasts do |t|

      t.timestamps null: false
    end
  end
end
