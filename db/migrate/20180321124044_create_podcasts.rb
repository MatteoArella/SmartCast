class CreatePodcasts < ActiveRecord::Migration
  def change
    create_table :podcasts do |t|
      t.string :name
      t.text :description
      t.string :image
      t.references :artist, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
