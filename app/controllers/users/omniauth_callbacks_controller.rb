class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def new_role
    unless session.key?("devise.oauth_data")
      redirect_to root_path
    end
  end

  def create_role
    role = sign_up_type_params[:type].gsub("\\", "")
    begin
      @user = User.from_omniauth(session["devise.oauth_data"], role)
    rescue ActiveRecord::RecordInvalid => invalid
      flash.error = invalid.record.errors
    end
    user_omniauth_sign_in(session["devise.oauth_data"]["provider"])
  end

  def failure
    redirect_to root_path
  end

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
        if current_user.avatar.nil?
          current_user.avatar = @identity.avatar
          current_user.save
        end
        redirect_to root_path, notice: "Successfully linked your #{omniauth_params.provider.capitalize} account!"
      end
    else
      if @identity.user.present?
        # The identity we found had a user associated with it so let's 
        # just log them in here
        @user = @identity.user
        user_omniauth_sign_in(omniauth_params.provider)
      else
        # No user associated with the identity so we need to create a new one

        # also check if there is a user with omniauth email
        @user = User.where(:email => omniauth_email(omniauth_params)).first
        if @user.nil?
          session["devise.oauth_data"] = omniauth_params
          @identity.save
          redirect_to new_user_role_path
        else
          # there is already a user registered with the same email
          @identity.user = @user
          @identity.save
          user_omniauth_sign_in(omniauth_params.provider)
        end
      end
    end
  end

  User::SOCIALS.each do |k, _|
    alias_method k, :omniauth_generic_callback
  end

  private

  def omniauth_email(auth)
    unless auth['provider'] == 'twitter'
      auth['info']['email']
    end
  end

  def user_omniauth_sign_in(provider)
    sign_in @user#, event: :authentication #this will throw if @user is not activated
    redirect_to root_path
    set_flash_message(:notice, :success, kind: User::SOCIALS[provider.to_sym]) if is_navigational_format?
  end

  def sign_up_type_params
    params.require(:user).permit(:type)
  end

  def omniauth_params
  	request.env["omniauth.auth"]
  end

end