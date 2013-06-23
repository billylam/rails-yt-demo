class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.first 

    #
    #https://github.com/ryanb/cancan/issues/646
    can :view, Playlist do |playlist|
      playlist && (!playlist.private || playlist.user_id == user.id || playlist.user.allow?(user))
    end

    can :read, User
    cannot :read, User, id:1
  end
end
