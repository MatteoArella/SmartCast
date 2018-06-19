class UserMailer < ApplicationMailer
	def sample_email(user)
  		@user = user
    	#@url  = 'http://example.com/login'
    	mail(to: 'tordi.simone@gmail.com' , subject: 'Welcome to My Awesome Site')
  	end
end
