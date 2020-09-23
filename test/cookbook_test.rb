require 'minitest/autorun'
require 'minitest/pride'
require './lib/ingredient'
require './lib/recipe'
require './lib/cook_book'
require 'mocha/minitest'

class CookbookTest < Minitest::Test
  def setup
    @recipe1 = Recipe.new("Mac and Cheese")
    @recipe2 = Recipe.new("Cheese Burger")
    Date.stubs(:today).returns(Date.new(2020,4,22))
    @cookbook = CookBook.new
  end

  def test_it_has_attributes
    assert_equal [], @cookbook.recipes
    assert_equal '04-22-2020', @cookbook.date
  end

  def test_it_can_add_recipes
    @cookbook.add_recipe(@recipe1)
    @cookbook.add_recipe(@recipe2)

    assert_equal [@recipe1, @recipe2], @cookbook.recipes
  end

  def test_it_can_return_list_of_ingredients
    @cookbook.add_recipe(@recipe1)
    @cookbook.add_recipe(@recipe2)

    ingredient1 = Ingredient.new({name: "Cheese", unit: "C", calories: 100})
    ingredient2 = Ingredient.new({name: "Macaroni", unit: "oz", calories: 30})
    ingredient3 = Ingredient.new({name: "Ground Beef", unit: "oz", calories: 100})
    ingredient4 = Ingredient.new({name: "Bun", unit: "g", calories: 75})

    @recipe1.add_ingredient(ingredient1, 2)
    @recipe1.add_ingredient(ingredient2, 8)

    @recipe2.add_ingredient(ingredient1, 2)
    @recipe2.add_ingredient(ingredient3, 4)
    @recipe2.add_ingredient(ingredient4, 1)

    expected = ["Cheese", "Macaroni", "Ground Beef", "Bun"]
    assert_equal expected, @cookbook.ingredients
  end

  def test_it_can_return_highest_calorie_recipe
    @cookbook.add_recipe(@recipe1)
    @cookbook.add_recipe(@recipe2)

    ingredient1 = Ingredient.new({name: "Cheese", unit: "C", calories: 100})
    ingredient2 = Ingredient.new({name: "Macaroni", unit: "oz", calories: 30})
    ingredient3 = Ingredient.new({name: "Ground Beef", unit: "oz", calories: 100})
    ingredient4 = Ingredient.new({name: "Bun", unit: "g", calories: 75})

    @recipe1.add_ingredient(ingredient1, 2)
    @recipe1.add_ingredient(ingredient2, 8)

    @recipe2.add_ingredient(ingredient1, 2)
    @recipe2.add_ingredient(ingredient3, 4)
    @recipe2.add_ingredient(ingredient4, 1)

    assert_equal @recipe2, @cookbook.highest_calorie_meal
  end

  def test_it_can_return_a_summary

  end
end
