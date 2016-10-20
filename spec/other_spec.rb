require 'other'

describe Other do
  subject(:other) { described_class.new(4, 10) }

  describe "one day update impact before or on sell_in date" do
    before do
      other.update_quality
    end
    it "decreases sell_in by 1" do
      expect(other.sell_in).to eq(3)
    end
    it "decreases quality by 1" do
      expect(other.quality).to eq(9)
    end
    it "decreases quality by 1 ON sell_in date" do
      3.times{other.update_quality}
      expect(other.quality).to eq(6)
    end
  end
  describe "one day update impact AFTER sell_in date" do
    before do
      5.times{other.update_quality}
    end
    it "decreases quality by 2 now" do
      expect(other.quality).to eq(4)
    end
    it "decreases sell_in by 1 still" do
      expect(other.sell_in).to eq(-1)
    end
  end

end
