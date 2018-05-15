class AddCachedVotesToPodcasts < ActiveRecord::Migration
  def change
    change_table :podcasts do |t|
      t.integer :cached_votes_total, default: 0
      t.integer :cached_votes_score, default: 0
      t.integer :cached_votes_up, default: 0
      t.integer :cached_votes_down, default: 0
    end

    # Uncomment this line to force caching of existing votes
    # Podcast.find_each(&:update_cached_votes)
  end
end
