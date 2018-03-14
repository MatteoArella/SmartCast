class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def facebook
    omniauth_generic_callback
  end

  def new_role
  end

  def create_role
    role = sign_up_role_params[:role].gsub("\\", "")
    begin
      @user = User.from_omniauth(session["devise.facebook_data"], role)
    rescue ActiveRecord::RecordInvalid => invalid
      flash.error = invalid.record.errors
    end
    user_omniauth_sign_in
  end

  def failure
    redirect_to root_path
  end

  private

  def omniauth_generic_callback
    #@user = User.where(provider: omniauth_params.provider, uid: omniauth_params.uid).first
    if User.where(email: omniauth_params.info.email).exists?
      @user = User.from_omniauth(omniauth_params, nil)
      user_omniauth_sign_in
    else # new user
      session["devise.facebook_data"] = omniauth_params
      redirect_to new_user_role_path # select role
    end
  end

  def user_omniauth_sign_in
    sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
    set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
  end

  def sign_up_role_params
    params.require(:user).permit(:role)
  end

  def omniauth_params
  	request.env["omniauth.auth"]
  end

end