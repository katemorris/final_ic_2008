require 'minitest/autorun'
require 'minitest/pride'
require './lib/ingredient'
require './lib/pantry'
require './lib/recipe'

class PantryTest < Minitest::Test
  def setup
    @pantry = Pantry.new
  end

  def test_it_has_attributes
    assert_empty @pantry.stock
  end

  def test_it_can_stock_ingredients
    ingredient1 = Ingredient.new({name: 'Cheese', unit: 'oz', calories: 50})
    ingredient2 = Ingredient.new({name: 'Macaroni', unit: 'oz', calories: 200})
    assert_equal 0, @pantry.stock_check(ingredient1)

    @pantry.restock(ingredient1, 5)
    @pantry.restock(ingredient1, 10)

    assert_equal 15, @pantry.stock_check(ingredient1)

    @pantry.restock(ingredient2, 7)

    assert_equal 7, @pantry.stock_check(ingredient2)

    expected = {
      ingredient1 => 15,
      ingredient2 => 7
    }

    assert_equal expected, @pantry.stock
  end

  def test_if_it_has_enough_ingredients_for_recipe
    ingredient1 = Ingredient.new({name: 'Cheese', unit: 'C', calories: 100})
    ingredient2 = Ingredient.new({name: 'Macaroni', unit: 'oz', calories: 30})

    recipe1 = Recipe.new("Mac and Cheese")
    recipe1.add_ingredient(ingredient1, 2)
    recipe1.add_ingredient(ingredient2, 8)

    @pantry.restock(ingredient1, 5)
    @pantry.restock(ingredient1, 10)
    assert_equal false, @pantry.enough_ingredients_for?(recipe1)

    @pantry.restock(ingredient2, 7)
    assert_equal false, @pantry.enough_ingredients_for?(recipe1)

    @pantry.restock(ingredient2, 1)
    assert @pantry.enough_ingredients_for?(recipe1)
  end
end
