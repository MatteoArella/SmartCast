require 'faker'

FactoryBot.define do

	factory :podcast do
		name		{ "Lorem Ipsum" }
		description	{ "Lorem ipsum dolor sit amet, consectetur adipiscing elit" }
		image		{ 'image.jpg' }

		factory :audiopodcast do
			type	{ 'AudioPodcast' }
		end

		factory :videopodcast do
			type	{ 'VideoPodcast' }
		end
	end
end