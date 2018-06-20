class FaqController < ApplicationController
	skip_before_filter :authenticate_user!

	def index
	end

	def contactUS
		  body = params[:body]
   		subject = params[:subject]
   		user_email = params[:email]
         AdminUser.all.each do |admin| 
   		    UserMailer.email_to_admin(current_user, admin, subject, body).deliver_later
         end
      UserMailer.email_to_user(current_user, user_email, subject).deliver_later
   		flash.notice = "Message correctly sent!! Your request will be managed as soon as possible." 
   		redirect_to root_path
   	end
end
