class UsersController < ApplicationController
	
	def index
	end

	def edit
		@user = User.find(params[:id])
	end

	def update

		@user= User.find(params[:id])
		if @user.update_attributes(user_params)
			flash[:success]= "Profile updated"
			redirect_to root_path

		else
			render 'edit'
		end

	
	end

	def show
		@user = User.find(params[:id])
	end

  private

  	def user_params
      params.require(:user).permit(:username, :password,
                                   :password_confirmation)  
  	end



end
