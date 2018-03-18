class Identity < ActiveRecord::Base
	belongs_to :user

	def self.from_omniauth(auth)
    where(uid: auth['uid'], provider: auth['provider']).first_or_create
  end
end