require 'conjured'
require 'item'

describe Conjured do

  subject(:conjured) {described_class.new(item)}
  let(:item) {Item.new(name="Conjured Mana Cake", sell_in=4, quality=20)}

  describe "one day update impact before or on sell_in date" do
    before do
      conjured.update
    end
    it "decreases sell_in by 1" do
      expect(item.sell_in).to eq(3)
    end
    it "decreases quality by 2" do
      expect(item.quality).to eq(18)
    end
    it "decreases quality by 2 ON sell_in date" do
      3.times{conjured.update}
      expect(item.quality).to eq(12)
    end
  end
  describe "one day update impact AFTER sell_in date" do
    before do
      5.times{conjured.update}
    end
    it "decreases sell_in by 1 still" do
      expect(item.sell_in).to eq(-1)
    end
    it "decreases quality by 2 now" do
      expect(item.quality).to eq(8)
    end
    it "cannot decrease quality below 0" do
      21.times{conjured.update}
      expect(item.quality).to eq(0)
    end
  end

end
