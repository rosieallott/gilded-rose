class Brie
  def initialize(item)
    @item = item
  end

  def update
    update_sell_in
    update_quality
  end

  private

  def update_quality
    item.quality += 1 if item.quality < 50
    item.quality += 1 if item.sell_in < 0 && item.quality < 50
  end

  def update_sell_in
    item.sell_in -= 1
  end

  attr_reader :item

end
