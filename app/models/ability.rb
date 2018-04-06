class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new

    if user.type == 'Learner'
        can :read, Podcast
        can :read, Episode
        cannot :create, Podcast
    end

    if user.type == 'Artist'
        can :crud, Podcast
        can :crud, Episode
        #can :read, Podcast
        #can :read, Episode
    end

    if user.type == 'AdminUser'
        can :manage, :all? 
    end
  end
end
