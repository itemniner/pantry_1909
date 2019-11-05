class Recipe
  attr_reader :name, :ingredients_required
  def initialize(name)
    @name = name
    @ingredients_required = {}
  end

  def add_ingredient(ingredient, amount)
    @ingredients_required[ingredient] = amount
  end
  
  def total_calories
    @ingredients_required.sum do |ingredient|
      ingredient[0].calories * ingredient.last
    end
  end
end
