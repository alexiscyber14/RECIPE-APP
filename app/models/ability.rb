class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, PublicRecipe
    cannot :read, Recipe
    return unless user.present?

    can :manage, Food, user_id: user
    can :manage, Recipe, user_id: user
  end
end
