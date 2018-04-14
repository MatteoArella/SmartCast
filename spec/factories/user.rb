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
	end

	factory :artist do
		FactoryBot.build(:user, :type => 'Artist')
	end

	factory :learner do
		FactoryBot.build(:user, :type => 'Learner')
	end

	factory :admin do
		FactoryBot.build(:user, :type => 'Admin')
	end
end