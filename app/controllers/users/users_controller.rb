class Users::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    render template: 'users/show'
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    if @user.destroy
    	redirect_to root_path, notice: "User deleted"
    end
  end

end