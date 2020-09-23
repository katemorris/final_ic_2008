class Pantry
  attr_reader :stock

  def initialize
    @stock = {}
  end

  def stock_check(ingredient)
    found_item = @stock.find do |item|
      item == ingredient
    end
    if found_item.nil?
      0
    else
      found_item.to_a.last
    end
  end
end
