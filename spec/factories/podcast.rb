require 'faker'

FactoryBot.define do

	factory :podcast do
		name		{ "Lorem Ipsum" }
		description	{ "Lorem ipsum dolor sit amet, consectetur adipiscing elit" }
		image		{ Rack::Test::UploadedFile.new(Rails.root.join('features', 'uploads', 'image.jpg'), 'image/jpeg') }
		type		{ 'AudioPodcast' }

		factory :audiopodcast do
			type	{ 'AudioPodcast' }
		end

		factory :videopodcast do
			type	{ 'VideoPodcast' }
		end
	end
end