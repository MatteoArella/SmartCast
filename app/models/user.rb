class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: %i[facebook]

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login

  validates :username, presence: :true, length: {maximum: 20 }, uniqueness: { case_sensitive: false }
  validate :validate_username

  validates :password_confirmation, presence: true, on: :create

  validates :role, presence: :true

  def self.from_omniauth(auth, role)
    password = Devise.friendly_token[0,20]
    User.create!(
      provider: auth["provider"],
      uid: auth["uid"],
      username: auth["info"]["name"],
      email: auth["info"]["email"],
      password: password,
      password_confirmation: password,
      avatar: auth["info"]["image"],
      role: role,
      confirmed_at: Date.today)
  end

	def validate_username
	  if User.where(email: username).exists?
	    errors.add(:username, :invalid)
	  end
	end

  def self.find_for_database_authentication(warden_conditions = {})
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_hash).first
    end
  end
end
