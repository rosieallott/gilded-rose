class BackstagePass
  def initialize(item)
    @item = item
  end

  def update
    update_sell_in
    update_quality
  end

  private

  def update_quality
    case
      when item.sell_in < 0 then item.quality = 0
      when item.sell_in <= 5 then (item.quality += 3 if item.quality < 50)
      when item.sell_in <=10 then (item.quality += 2 if item.quality < 50)
      when item.sell_in > 10 then (item.quality += 1 if item.quality < 50)
    end
  end

  def update_sell_in
    item.sell_in -= 1
  end

  attr_reader :item
end
