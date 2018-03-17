class Users::UsersController < ApplicationController
	def settings
		@user = current_user
		render template: 'users/settings'
	end
end