class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
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
    @identity = Identity.from_omniauth(omniauth_params)

    if signed_in?
      if @identity.user == current_user
        # User is signed in so they are trying to link an identity with their
        # account. But we found the identity and the user associated with it 
        # is the current user. So the identity is already associated with 
        # this user. So let's display an error message.
        redirect_to root_path, notice: "Already linked that account!"
      else
        # The identity is not associated with the current_user so lets 
        # associate the identity
        @identity.user = current_user
        @identity.save
        redirect_to root_path, notice: "Successfully linked that account!"
      end
    else
      if @identity.user.present?
        # The identity we found had a user associated with it so let's 
        # just log them in here
        self.current_user = @identity.user
        redirect_to root_url, notice: "Signed in!"
      else
        # No user associated with the identity so we need to create a new one
        redirect_to new_user_url, notice: "Please finish registering"
      end
    end

    =begin
    if User.where(email: omniauth_params.info.email).exists?
      @user = User.from_omniauth(omniauth_params, nil)
      user_omniauth_sign_in
    else # new user
      session["devise.facebook_data"] = omniauth_params
      redirect_to new_user_role_path # select role
    end
    =end
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