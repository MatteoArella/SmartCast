class Learner < User

	

	def learner?
    	true
  	end

  	def guest?
     	#this method return true if the User are not logged in the system
     	false
    end
    
end