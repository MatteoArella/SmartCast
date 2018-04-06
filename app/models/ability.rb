class Ability
  include CanCan::Ability

  def initialize(user)

    if user.type == 'Learner'
        can :read, Podcast
        can :read, Episode
    end

    if user.type == 'Artist'
        can :crud, Podcast, :user_id => user.id
        can :crud, Podcast, :user_id => user.id
        can :read, Podcast
        can :read, Episode
    end

    if user.type == 'AdminUser'
        can :manage, :all? 
    end
  end
end
