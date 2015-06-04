class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    
    # Admin User Privileges
    if user.admin?
      can :manage, :all
      
    # Regular User Privileges
    elsif user.id
    
      # Stories
      can :create, Story
      can :update, Story do |story| # Job poster can edit his/her own posted stories
        story.try(:user) == user
      end
      can :upvote, Story # Can like stories
      
      # Comments
      can :create, Comment
    end
    
    # Guest User Priveleges
    can :read, :all
  end
end
