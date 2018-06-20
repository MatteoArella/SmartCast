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
      UserMailer.email_to_user(current_user, user_email, subject, body).deliver_later
   		flash.notice = "Message correctly sent!! <br/><br/><br/>" + subject + body
   		redirect_to faq_path
   	end
end
