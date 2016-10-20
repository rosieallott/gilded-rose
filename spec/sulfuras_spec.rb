require 'sulfuras'

describe Sulfuras do
  subject(:sulfuras) { described_class.new(0, 10) }

  describe "one day update impact" do
    before do
      sulfuras.update_quality
    end
    it "no sell_in date" do
      expect(sulfuras.sell_in).to eq(0)
    end
    it "quality remains the same" do
      expect(sulfuras.quality).to eq(10)
    end
    it "quality always remains the same" do
      5.times{sulfuras.update_quality}
      expect(sulfuras.quality).to eq(10)
    end
  end
end
