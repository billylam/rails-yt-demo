class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.first 
    can :view, Playlist do |playlist|
      playlist && (!playlist.private || playlist.user_id == user.id || playlist.user.allow?(user))
    end
  end
end
