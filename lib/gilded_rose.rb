class GildedRose

  def initialize(items)
    @items = items
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

  def update_quality_other
    @items.each do |item|
      item.quality -= 1 if item.quality < 50
      item.quality -= 1 if item.sell_in < 0 && item.quality < 50
    end
  end

  def update_quality()
    @items.each do |item|
      update_sell_in unless item.name == "Sulfuras, Hand of Ragnaros"
      case
        when item.name == "Aged Brie" then update_quality_brie
        when item.name == "Sulfuras, Hand of Ragnaros" then update_quality_sulfuras
        when item.name == "Backstage passes to a TAFKAL80ETC concert" then update_quality_backstage
        else update_quality_other
      end
      # if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
      #   if item.quality > 0
      #     if item.name != "Sulfuras, Hand of Ragnaros"
      #       item.quality = item.quality - 1
      #     end
      #   end
      # else
      #   if item.quality < 50
      #     item.quality = item.quality + 1
      #     if item.name == "Backstage passes to a TAFKAL80ETC concert"
      #       if item.sell_in < 11
      #         if item.quality < 50
      #           item.quality = item.quality + 1
      #         end
      #       end
      #       if item.sell_in < 6
      #         if item.quality < 50
      #           item.quality = item.quality + 1
      #         end
      #       end
      #     end
      #   end
      # end
      # if item.name != "Sulfuras, Hand of Ragnaros"
      #   item.sell_in = item.sell_in - 1
      # end
      # if item.sell_in < 0
      #   if item.name != "Aged Brie"
      #     if item.name != "Backstage passes to a TAFKAL80ETC concert"
      #       if item.quality > 0
      #         if item.name != "Sulfuras, Hand of Ragnaros"
      #           item.quality = item.quality - 1
      #         end
      #       end
      #     else
      #       item.quality = item.quality - item.quality
      #     end
      #   else
      #     if item.quality < 50
      #       item.quality = item.quality + 1
      #     end
      #   end
      # end
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
