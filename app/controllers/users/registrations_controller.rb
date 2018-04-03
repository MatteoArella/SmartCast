class Users::RegistrationsController < Devise::RegistrationsController
	prepend_before_action :check_captcha, only: [:create] # Change this to be any actions you want to protect.

  def edit
    @user = current_user
    render template: 'users/edit'
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

  def sign_up_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :type).tap do |par|
      par.except :type unless User::PERMITTED_ROLES.include? par[:type]
    end
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password)
  end

  def check_captcha
    unless verify_recaptcha
      self.resource = resource_class.new sign_up_params
      resource.validate # Look for any other validation errors besides Recaptcha
      respond_with_navigational(resource) { render :new }
    end 
  end

  def change_username_params
    params.require(:user).permit(:username)
  end

  def change_password_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end  
end