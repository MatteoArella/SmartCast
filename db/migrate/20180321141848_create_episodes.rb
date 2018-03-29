class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.string :name
      t.text :description
      t.string :image
      t.references :podcast, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
