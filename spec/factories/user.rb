require 'faker'

FactoryBot.define do
	password = Devise.friendly_token

	factory :user do
		username								{ Faker::Internet.unique.user_name(1..20) }
		email									{ Faker::Internet.unique.email }
		password 								{ password }
    	password_confirmation 					{ password }
		type									{ 'Artist' }
		confirmed_at							{ Date.today }
		avatar									nil

		factory :artist do
			type								{ 'Artist' }
		end

		factory :learner do
			type								{ 'Learner' }
		end

		factory :admin do
			type								{ 'AdminUser' }
		end
	end
end