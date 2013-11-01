class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
      can :manage, :all

    elsif user.persisted?
      # POSTS
      can :read, Post, moderation_state: 'accepted'
      can :create, Post

      can :update, Post, author_id: user.id

      # COMMENTS
      can :read, Comment
      can :create, Comment
    else
      can :read, Post, moderation_state: 'accepted'

      can :read, Comment
      can :create, Comment
    end
  end
end
