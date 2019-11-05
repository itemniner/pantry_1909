class Pantry
  attr_reader :stock
  def initialize
    @stock = {}
  end

  def stock_check(ingredient)
    @stock.sum do |food|
      food.last
    end
  end

  def restock(ingredient, amount)
    @stock.default = 0
    @stock[ingredient] += amount
  end

  def enough_ingredients(recipe)
    recipe.ingredients_required
    @stock.reduce({}) do |sum, ingredient|
      recipe.ingredients_required[ingredient.first] -= ingredient.last
    end
    recipe.ingredients_required.values
  end

  def enough_ingredients_for?(recipe)
    enough_ingredients(recipe).all?{ |num| num <= 0 }
  end
end
