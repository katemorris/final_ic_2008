require 'minitest/autorun'
require 'minitest/pride'
require './lib/ingredient'
require './lib/pantry'

class IngredientTest < Minitest::Test
  def setup
    @ingredient1 = Ingredient.new({name: 'Cheese', unit: 'oz', calories: 50})
    @ingredient2 = Ingredient.new({name: "Macaroni", unit: "oz", calories: 200})
    @pantry = Pantry.new
  end

  def test_it_has_attributes
    assert_empty @pantry.stock
  end

  def test_it_can_stock_ingredients
    assert_equal 0, @pantry.stock_check(@ingredient1)
    
    @pantry.restock(@ingredient1, 5)
    @pantry.restock(@ingredient1, 10)

    assert_equal 15, @pantry.stock_check(@ingredient1)

    @pantry.restock(@ingredient2, 7)

    assert_equal 7, @pantry.stock_check(@ingredient2)

    expected = {
      @ingredient1 => 15,
      @ingredient2 => 7
    }

    assert_equal expected, @pantry.stock
  end
end
