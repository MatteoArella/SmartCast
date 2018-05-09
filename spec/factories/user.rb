require 'faker'

FactoryBot.define do
	password = Devise.friendly_token

	factory :user do
		username								{ Faker::Internet.unique.user_name(1..20) }
		email									{ Faker::Internet.unique.email }
		password 								{ password }
    	password_confirmation 					{ password }
		type									{ 'Learner' }
		confirmed_at							{ Date.today }
		avatar									nil

		factory :learner do
			type								{ 'Learner' }

			factory :artist do
				type							{ 'Artist' }
			end
		end

		factory :admin do
			type								{ 'AdminUser' }
		end
	end
end