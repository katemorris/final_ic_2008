class CookBook
  attr_reader :recipes
  def initialize
    @recipes = []
  end

  def add_recipe(recipe)
    @recipes << recipe
  end

  def ingredients
    @recipes.each_with_object([]) do |recipe, array|
      array << recipe.ingredients.map { |ingredient| ingredient.name }
    end.flatten.uniq
  end
end
