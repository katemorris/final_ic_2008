class Recipe
  attr_reader :name, :ingredients_required, :ingredients

  def initialize(name)
    @name = name
    @ingredients_required = {}
    @ingredients = []
  end

  def add_ingredient(ingredient, amount)
    @ingredients_required[ingredient] ||= 0
    @ingredients_required[ingredient] += amount
    add_unique_ingredient(ingredient)
  end

  def add_unique_ingredient(ingredient)
    if !@ingredients.include?(ingredient)
      @ingredients << ingredient
    end
  end
end
