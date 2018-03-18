class Users::UsersController < ApplicationController
	def settings
		@user = current_user
		render template: 'users/settings'
	end

	def change_password
		if @user.current_password == change_password_params[:current_password]
			edirect_to root_path
		else
			redirect_to root_path
		end
	end


	private
	def change_password_params
		params.require(:user).permit(:current_password, :password, :password_confirmation)
	end
end