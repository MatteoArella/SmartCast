class Users::SessionsController < Devise::SessionsController

	def destroy
    super
    session.delete(:user_role) if session.key?(:user_role)
  end

end