class AddCategoryToPodcast < ActiveRecord::Migration
  def change
  	add_column :podcasts, :category, :string, null: :false
  end
end
