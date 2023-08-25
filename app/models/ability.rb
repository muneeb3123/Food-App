class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    
    if user.role == 'admin'
      can :manage, :all
    else
      can :read, :all
      can :manage, [Food, Recipe], user_id: user.id
      
      user.recipes.each do |recipe|
        can :manage, RecipeFood, recipe_id: recipe.id
      end
    end
  end
end
