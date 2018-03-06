class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def facebook
    @user = User.from_omniauth(omniauth_params, session[:user_role])
    if @user.persisted? # already signed up user, i.e. sign in
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    else #sign up
      session["devise.facebook_data"] = omniauth_params
      redirect_to new_user_registration_url
      flash.notice = "Successfully Signed Up with Facebook"
      redirect_to root_path
    end
  end

  def failure
    redirect_to root_path
  end

  private

  def omniauth_params
  	request.env["omniauth.auth"]
  end

end