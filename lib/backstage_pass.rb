class BackstagePass
  def initialize(sell_in, quality)
    @sell_in = sell_in
    @quality = quality
  end

  def update_quality
    @sell_in -= 1 
    case
      when @sell_in < 0 then @quality = 0
      when @sell_in <= 5 then (@quality += 3 if @quality < 50)
      when @sell_in <=10 then (@quality += 2 if @quality < 50)
      when @sell_in > 10 then (@quality += 1 if @quality < 50)
    end
  end

  attr_reader :sell_in, :quality
end
