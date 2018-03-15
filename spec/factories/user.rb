require 'faker'

FactoryBot.define do
	password = Devise.friendly_token
	factory :user do
		username								{ Faker::Internet.unique.user_name(1..20) }
		email										{ Faker::Internet.unique.email }
		password 								{ password }
    password_confirmation 	{ password }
		role										{ 'artist' }
		confirmed_at						{ Date.today }
		provider								nil
		uid											nil
		avatar									nil
	end
end