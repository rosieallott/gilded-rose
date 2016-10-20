require 'other'
require 'item'

describe Other do
  subject(:other) { described_class.new(item) }
  let(:item) {Item.new(name="anything else", sell_in=4, quality=10)}

  describe "one day update impact before or on sell_in date" do
    before do
      other.update
    end
    it "decreases sell_in by 1" do
      expect(item.sell_in).to eq(3)
    end
    it "decreases quality by 1" do
      expect(item.quality).to eq(9)
    end
    it "decreases quality by 1 ON sell_in date" do
      3.times{other.update}
      expect(item.quality).to eq(6)
    end
  end
  describe "one day update impact AFTER sell_in date" do
    before do
      5.times{other.update}
    end
    it "decreases quality by 2 now" do
      expect(item.quality).to eq(4)
    end
    it "decreases sell_in by 1 still" do
      expect(item.sell_in).to eq(-1)
    end
  end

end
