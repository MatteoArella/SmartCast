class UserMailer < ApplicationMailer
	def email_to_admin(user, admin, subject, body)
  		@user = user
  		@subject = subject
  		@body = body
  		@admin = admin
    	mail(to: @admin.email)
  	end

  	def email_to_user(user, email, subject, body) 
  		@user = user
  		@subject = subject
  		@body = body
  		@email = email
    	#@url  = 'http://example.com/login'
    	mail(to: @email)
  	end
end
