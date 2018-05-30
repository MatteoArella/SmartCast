class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.guest?
        cannot :manage, :any
    end

    if user.learner?
        can :read, Podcast
        can :read, Episode
    end

    if user.artist?
        can :create, Podcast
        #can :create, Episode, :artist_id => user.id
        can :update, Podcast, :artist_id => user.id
        can :destroy, Podcast, :artist_id => user.id
        can :update, Episode, :artist_id => user.id
        can :destroy, Episode, :artist_id => user.id
    end

    if user.admin?
        can :manage, :all #For example, the AdminUser also can 
        cannot :create, Podcast
        cannot :create, Episode
    end
  end
end
