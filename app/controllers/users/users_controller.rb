class Users::UsersController < ApplicationController

	def settings
		@user = current_user
		render template: 'users/settings'
	end

	def update_username
		@user = current_user

		if @user.update_attribute(:username, change_username_params[:username])
      # Sign in the user by passing validation in case their password changed
      bypass_sign_in(@user)

      flash.notice = t("devise.registrations.updated")
      redirect_to root_path
    else
    	flash.notice = @user.errors.full_messages.to_sentence
    	redirect_to account_settings_path
    end
	end

	def update_password
    @user = current_user

    if @user.update_with_password(change_password_params)
      # Sign in the user by passing validation in case their password changed
      bypass_sign_in(@user)

      flash.notice = t("devise.passwords.updated_not_active")
      redirect_to root_path
    else
    	flash.notice = @user.errors.full_messages.to_sentence
    	redirect_to account_settings_path
    end
  end


	private
	def change_username_params
		params.require(:user).permit(:username)
	end

	def change_password_params
		params.require(:user).permit(:current_password, :password, :password_confirmation)
	end
end