class UserMailer < ApplicationMailer
	def email_to_admin(user, admin, subject, body)
  		@user = user
  		@subject = subject
  		@body = body
  		@admin = admin
    	mail(to: @admin.email, subject: @subject)
  	end

  	def email_to_user(user, email, subject) 
  		@user = user
  		@subject = subject
  		@email = email
    	#@url  = 'http://example.com/login'
    	mail(to: @email, subject: 'SmartCast Support' + ' - ' + @subject)
  	end
end
