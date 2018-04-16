class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.guest?
        cannot :manage, :any?
    end
    
    if user.learner?
        can :read, Podcast
        can :read, Episode
        #cannot :create, Podcast
    end

    if user.artist?
        can :create, Podcast
        can :create, Episode
        can :update, Podcast, :user_id => user.id
        can :delete, Podcast, :user_id => user.id
        can :update, Episode, :user_id => user.id
        can :delete, Episode, :user_id => user.id
    end

    if user.admin?
        can :manage, :all? #For example, the AdminUser also can 
    end
  end
end
