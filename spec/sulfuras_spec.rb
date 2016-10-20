require 'sulfuras'
require 'item'

describe Sulfuras do
  subject(:sulfuras) { described_class.new(item) }
  let(:item) {Item.new(name="Sulfuras, Hand of Ragnaros", sell_in=0, quality=10)}

  describe "one day update impact" do
    before do
      sulfuras.update
    end
    it "no sell_in date" do
      expect(item.sell_in).to eq(0)
    end
    it "quality remains the same" do
      expect(item.quality).to eq(10)
    end
    it "quality always remains the same" do
      5.times{sulfuras.update}
      expect(item.quality).to eq(10)
    end
  end
end
