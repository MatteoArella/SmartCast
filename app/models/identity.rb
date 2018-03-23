class Identity < ActiveRecord::Base
	belongs_to :user

	validates :uid, presence: :true
	validates :provider, presence: :true

	def self.from_omniauth(auth)
    where(uid: auth['uid'], provider: auth['provider']).first_or_create do |identity|
    	identity.username = auth['info']['name']
    	identity.email = auth['info']['email']
    	identity.avatar = auth['info']['image']
    end
  end
end