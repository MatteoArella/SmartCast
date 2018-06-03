require 'faker'

FactoryBot.define do

	factory :podcast do
		title		{ "Lorem Ipsum" }
		description	{ "Lorem ipsum dolor sit amet, consectetur adipiscing elit" }
		image		{ Rack::Test::UploadedFile.new(Rails.root.join('features', 'uploads', 'image.jpg'), 'image/jpeg') }
		category	{ 'AudioPodcast' }

		factory :audiopodcast do
			category	{ 'AudioPodcast' }
		end

		factory :videopodcast do
			category	{ 'VideoPodcast' }
		end
	end
end