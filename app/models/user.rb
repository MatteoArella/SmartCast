class User < ActiveRecord::Base

  SOCIALS = {
    facebook: 'Facebook'
  }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: SOCIALS.keys

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login

  has_many :identities, :dependent => :destroy

  validates :username, presence: :true, length: { maximum: 20 }
  validates_uniqueness_of :username
  validate :validate_username

  validates :password_confirmation, presence: :true
  validates_confirmation_of :password

  validates :role, presence: :true

  def self.from_omniauth(auth, role)
    identity = Identity.where(uid: auth['uid'], provider: auth['provider']).first
    password = Devise.friendly_token[0, 20]
    user = User.new
    user.fetch_details(auth)
    user.role = role
    user.skip_confirmation!
    user.password = password
    user.password_confirmation = password
    user.save
    identity.user = user
    identity.save
    user
  end

	def validate_username
	  if User.where(email: username).exists?
	    errors.add(:username, :invalid)
	  end
	end

  def password_required?
    super
  end

  def self.find_for_database_authentication(warden_conditions = {})
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_hash).first
    end
  end

  def fetch_details(auth)
    unless auth["provider"] == 'twitter'
      self.username = auth["info"]["name"]
      self.email = auth["info"]["email"]
      self.avatar = auth["info"]["image"]
    end
  end
end
