require_relative 'item'
require_relative 'brie'
require_relative 'backstage_pass'
require_relative 'conjured'
require_relative 'sulfuras'
require_relative 'other'

class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      update_sell_in unless item.name == "Sulfuras, Hand of Ragnaros"
      case
        when item.name == "Aged Brie" then update_quality_brie
        when item.name == "Sulfuras, Hand of Ragnaros" then update_quality_sulfuras
        when item.name == "Backstage passes to a TAFKAL80ETC concert" then update_quality_backstage
        when item.name == "Conjured Mana Cake" then update_quality_conjured
        else update_quality_other
      end
    end
  end

  def update_sell_in
    @items.each do |item|
      item.sell_in -= 1
    end
  end

  def update_quality_brie
    @items.each do |item|
      item.quality += 1 if item.quality < 50
      item.quality += 1 if item.sell_in < 0 && item.quality < 50
    end
  end

  def update_quality_sulfuras

  end

  def update_quality_backstage
    @items.each do |item|
      case
        when item.sell_in < 0 then item.quality = 0
        when item.sell_in <= 5 then (item.quality += 3 if item.quality < 50)
        when item.sell_in <=10 then (item.quality += 2 if item.quality < 50)
        when item.sell_in > 10 then (item.quality += 1 if item.quality < 50)
      end
    end
  end

  def update_quality_conjured
    @items.each do |item|
      item.quality -= 2 if item.quality > 0
      item.quality -= 2 if item.sell_in < 0 && item.quality > 0
    end
  end

  def update_quality_other
    @items.each do |item|
      item.quality -= 1 if item.quality > 0
      item.quality -= 1 if item.sell_in < 0 && item.quality > 0
    end
  end

end
