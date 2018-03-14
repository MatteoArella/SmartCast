class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: %i[facebook]

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login

  validates :username, presence: :true, length: { maximum: 20 }
  validates_uniqueness_of :username
  validate :validate_username

  validates :role, presence: :true

  def self.from_omniauth(auth, role)
    # first user from omniauth
    if role.nil?
      user = User.where(email: auth["info"]["email"]).first
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      #user.username = auth["info"]["name"]
      user.avatar = auth["info"]["image"]
    else
      user = User.create!(
      provider: auth["provider"],
      uid: auth["uid"],
      username: auth["info"]["name"],
      email: auth["info"]["email"],
      #password: password,
      #password_confirmation: password,
      avatar: auth["info"]["image"],
      role: role,
      confirmed_at: Date.today)
    end
    user
  end

	def validate_username
	  if User.where(email: username).exists?
	    errors.add(:username, :invalid)
	  end
	end

  def validate_email
    if User.where(email: email, provider: [nil, ""]).exists?
      errors.add(:email, :invalid)
    end
  end

  def email_required?
    super && provider.blank?
  end

  def password_required?
    super && provider.blank?
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
