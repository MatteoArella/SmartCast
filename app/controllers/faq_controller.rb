class FaqController < ApplicationController
	skip_before_filter :authenticate_user!

	def index
		UserMailer.sample_email(current_user).deliver
	end
end
