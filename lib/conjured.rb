class Conjured
  def initialize(sell_in, quality)
    @sell_in = sell_in
    @quality = quality
  end

  def update_quality
    @sell_in -= 1
    @quality -= 2 if @quality > 0
    @quality -= 2 if @sell_in < 0 && @quality > 0
  end

  attr_reader :sell_in, :quality
end
