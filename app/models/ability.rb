class Ability
  include CanCan::Ability

  # Abilities of the users, defined by role %>
  def initialize(user)
    # Guest user (not logged in)
    user ||= User.new
    can [:show, :edit, :update, :destroy], User, :id => user.id # Everyone can see see, edit and destroy
    can :read, Course
    can :create, User

    if user.has_role? :Cursist
      can :read, Course

    elsif user.has_role? :Medewerker
      can :manage, Course
      can :manage, CourseKind
      can :manage, Ship

    elsif user.has_role? :Beheerder
      can :manage, :all
    end
  end
end
