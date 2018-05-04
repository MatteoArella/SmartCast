class Users::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    render template: 'users/show'
  end
end