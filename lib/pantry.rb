class Pantry
  attr_reader :stock

  def initialize
    @stock = {}
  end

  def stock_check(ingredient)
    found_item = @stock.select do |item|
      item == ingredient
    end
    if found_item.empty?
      0
    else
      found_item[ingredient]
    end
  end

  def restock(item, amount)
    @stock[item] ||= 0
    @stock[item] += amount
  end

  def enough_ingredients_for?(recipe)
    recipe.ingredients_required.all? do |ingredient, amount|
      stock_check(ingredient) >= amount
    end
  end
end
