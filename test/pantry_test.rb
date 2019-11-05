require 'minitest/autorun'
require 'minitest/pride'
require './lib/pantry'
require './lib/ingredient'
require './lib/recipe'

class PantryTest < Minitest::Test
  def setup
    @pantry = Pantry.new
    @cheese = Ingredient.new("Cheese", "C", 50)
    @mac = Ingredient.new("Macaroni", "oz", 200)
    @mac_and_cheese = Recipe.new("Mac and Cheese")
    @mac_and_cheese.add_ingredient(@cheese, 2)
    @mac_and_cheese.add_ingredient(@mac, 8)
  end

  def test_it_exist
    assert_instance_of Pantry, @pantry
  end

  def test_pantry_stock_starts_empty
    assert_equal Hash.new, @pantry.stock
  end

  def test_it_can_check_stock
    assert_equal 0, @pantry.stock_check(@cheese)
  end

  def test_it_can_restock
    @pantry.restock(@cheese, 5)
    @pantry.restock(@cheese, 10)
    assert_equal 15, @pantry.stock_check(@cheese)
  end

  def test_it_has_enough_ingredients_for
    @pantry.restock(@cheese, 5)
    @pantry.restock(@cheese, 10)
    refute @pantry.enough_ingredients_for?(@mac_and_cheese)
    @pantry.restock(@mac, 7)
    refute @pantry.enough_ingredients_for?(@mac_and_cheese)
    @pantry.restock(@mac, 1)
    assert_equal true, @pantry.enough_ingredients_for?(@mac_and_cheese)
  end
end
