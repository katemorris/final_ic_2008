require 'date'
class CookBook
  attr_reader :recipes, :date
  def initialize
    @recipes = []
    @date = Date.today.strftime('%m-%d-%Y')
  end

  def add_recipe(recipe)
    @recipes << recipe
  end

  def ingredients
    @recipes.each_with_object([]) do |recipe, array|
      array << recipe.ingredients.map { |ingredient| ingredient.name }
    end.flatten.uniq
  end

  def highest_calorie_meal
    @recipes.max_by do |recipe|
      recipe.total_calories
    end
  end

  def summary
    @recipes.each_with_object([]) do |recipe, array|
      recipe.each_with_object({}) do |recipe, hash|
        hash[:name] = recipe.name
        hash[:details] = recipe.ingredients_required
        hash[:total_calories] = recipe.total_calories
      end
    end
  end
end
