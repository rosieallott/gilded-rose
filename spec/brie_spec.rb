require 'brie'

describe Brie do
  subject(:brie) { described_class.new(item) }
  let(:item) {Item.new(name="Aged Brie", sell_in=4, quality=20)}

  describe "one day update impact before or on sell_in date" do
    before do
      brie.update
    end
    it "decreases sell_in by 1" do
      expect(item.sell_in).to eq(3)
    end
    it "increases quality by 1" do
      expect(item.quality).to eq(21)
    end

  end
  describe "one day update impact AFTER sell_in date" do
    before do
      5.times{brie.update}
    end
    it "still increases quality by 1" do
      expect(item.quality).to eq(26)
    end
    it "decreases sell_in by 1 still" do
      expect(item.sell_in).to eq(-1)
    end
    it "50 is maximum quality" do
      20.times{brie.update}
      expect(item.quality).to eq(50)
    end
  end

end
