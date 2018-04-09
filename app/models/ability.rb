class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.learner?
        can :read, Podcast
        can :read, Episode
        #cannot :create, Podcast
    end

    if user.artist?
        can :create, Podcast
        can :create, Episode
        can :update, :delete, Podcast, :user_id => user.id
        can :update, :delete, Episode, :user_id => user.id
    end

    if user.admin?
        can :manage, :all? #For example, the AdminUser also can 
    end

    if user.type == 'User'

  end
end
