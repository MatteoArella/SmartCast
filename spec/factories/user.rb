require 'faker'

FactoryBot.define do
	factory :user do
		username								{ Faker::Internet.unique.user_name(1..20) }
		email										{ Faker::Internet.unique.email }
		password 								"secretpassword"
    password_confirmation 	"secretpassword"
		role										{ 'artist' }
		confirmed_at						{ Date.today }
	end
end