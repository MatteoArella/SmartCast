# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'


# create users
artist1 = Artist.create(:email => 'artist01@user.com',
						:username => 'artist01',
						:password => 'artist01',
						:password_confirmation => 'artist01',
						:confirmed_at => Time.now)

artist2 = Artist.create(:email => 'artist02@user.com',
						:username => 'artist02',
						:password => 'artist02',
						:password_confirmation => 'artist02',
						:confirmed_at => Time.now)

artist3 = Artist.create(:email => 'artist03@user.com',
						:username => 'artist03',
						:password => 'artist03',
						:password_confirmation => 'artist03',
						:confirmed_at => Time.now)

artist4 = Artist.create(:email => 'artist04@user.com',
						:username => 'artist04',
						:password => 'artist04',
						:password_confirmation => 'artist04',
						:confirmed_at => Time.now)

learner1 = Learner.create(:email => 'learner01@user.com',
						:username => 'learner01',
						:password => 'learner01',
						:password_confirmation => 'learner01',
						:confirmed_at => Time.now)

learner2 = Learner.create(:email => 'learner02@user.com',
						:username => 'learner02',
						:password => 'learner02',
						:password_confirmation => 'learner02',
						:confirmed_at => Time.now)

learner3 = Learner.create(:email => 'learner03@user.com',
						:username => 'learner03',
						:password => 'learner03',
						:password_confirmation => 'learner03',
						:confirmed_at => Time.now)

learner4 = Learner.create(:email => 'learner04@user.com',
						:username => 'learner04',
						:password => 'learner04',
						:password_confirmation => 'learner04',
						:confirmed_at => Time.now)

AdminUser.create(:email => 'admin@user.com',
						:username => 'admin',
						:password => 'admin001',
						:password_confirmation => 'admin001',
						:confirmed_at => Time.now)

# create podcasts
pod1 = Podcast.create(:title => Faker::Lorem.characters(8),
										:description => Faker::Lorem.characters(10),
										:image => Rails.root.join("features/uploads/image.jpg").open,
										:artist_id => artist1.id,
										:category => 'AudioPodcast')

pod2 = Podcast.create(:title => Faker::Lorem.characters(8),
										:description => Faker::Lorem.characters(10),
										:image => Rails.root.join("features/uploads/image.jpg").open,
										:artist_id => artist2.id,
										:category => 'AudioPodcast')

pod3 = Podcast.create(:title => Faker::Lorem.characters(8),
										:description => Faker::Lorem.characters(10),
										:image => Rails.root.join("features/uploads/image.jpg").open,
										:artist_id => artist3.id,
										:category => 'AudioPodcast')

pod4 = Podcast.create(:title => Faker::Lorem.characters(8),
										:description => Faker::Lorem.characters(10),
										:image => Rails.root.join("features/uploads/image.jpg").open,
										:artist_id => artist1.id,
										:category => 'AudioPodcast')

pod5 = Podcast.create(:title => Faker::Lorem.characters(8),
										:description => Faker::Lorem.characters(10),
										:image => Rails.root.join("features/uploads/image.jpg").open,
										:artist_id => artist2.id,
										:category => 'AudioPodcast')

pod6 = Podcast.create(:title => Faker::Lorem.characters(8),
										:description => Faker::Lorem.characters(10),
										:image => Rails.root.join("features/uploads/image.jpg").open,
										:artist_id => artist3.id,
										:category => 'AudioPodcast')

pod7 = Podcast.create(:title => Faker::Lorem.characters(8),
										:description => Faker::Lorem.characters(10),
										:image => Rails.root.join("features/uploads/image.jpg").open,
										:artist_id => artist1.id,
										:category => 'AudioPodcast')

pod8 = Podcast.create(:title => Faker::Lorem.characters(8),
										:description => Faker::Lorem.characters(10),
										:image => Rails.root.join("features/uploads/image.jpg").open,
										:artist_id => artist2.id,
										:category => 'AudioPodcast')

pod9 = Podcast.create(:title => Faker::Lorem.characters(8),
										:description => Faker::Lorem.characters(10),
										:image => Rails.root.join("features/uploads/image.jpg").open,
										:artist_id => artist3.id,
										:category => 'AudioPodcast')

pod10 = Podcast.create(:title => Faker::Lorem.characters(8),
										:description => Faker::Lorem.characters(10),
										:image => Rails.root.join("features/uploads/image.jpg").open,
										:artist_id => artist1.id,
										:category => 'AudioPodcast')

pod11 = Podcast.create(:title => Faker::Lorem.characters(8),
										:description => Faker::Lorem.characters(10),
										:image => Rails.root.join("features/uploads/image.jpg").open,
										:artist_id => artist2.id,
										:category => 'AudioPodcast')

pod12 = Podcast.create(:title => Faker::Lorem.characters(8),
										:description => Faker::Lorem.characters(10),
										:image => Rails.root.join("features/uploads/image.jpg").open,
										:artist_id => artist1.id,
										:category => 'VideoPodcast')

video = VideoEpisode.create(:title => Faker::Lorem.characters(8),
										:description => Faker::Lorem.characters(10),
										:image => Rails.root.join("features/uploads/image.jpg").open,
										:podcast_id => pod12.id,
										:mp4 => Rails.root.join("features/uploads/video.mp4").open)

audio = AudioEpisode.create(:title => Faker::Lorem.characters(8),
										:description => Faker::Lorem.characters(10),
										:image => Rails.root.join("features/uploads/image.jpg").open,
										:podcast_id => pod10.id,
										:mp3 => Rails.root.join("features/uploads/audio.mp3").open)