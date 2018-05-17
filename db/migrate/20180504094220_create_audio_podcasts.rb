class CreateAudioPodcasts < ActiveRecord::Migration
  def change
    create_table :audio_podcasts do |t|

      t.timestamps null: false
    end
  end
end
