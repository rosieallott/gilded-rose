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

  def update
    @items.each {|item| item_of_type(item).update}
  end

  private

  ITEMS = {"Aged Brie" => Brie, "Sulfuras, Hand of Ragnaros" => Sulfuras,
          "Backstage passes to a TAFKAL80ETC concert" => BackstagePass,
          "Conjured Mana Cake" => Conjured}

  def known_item?(item)
    ITEMS.include?(item.name)
  end

  def item_of_type(item)
    known_item?(item) ? ITEMS[item.name].new(item) : Other.new(item)
  end

  attr_reader :item, :items
  
end
