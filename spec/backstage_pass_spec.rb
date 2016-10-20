require 'backstage_pass'
require 'item'

describe BackstagePass do
  subject(:backstage_pass) { described_class.new(item) }
  let(:item) {Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=12, quality=10)}

  describe "one day update impact > 10 days away" do
    before do
      backstage_pass.update
    end
    it "decreases sell_in by 1" do
      expect(item.sell_in).to eq(11)
    end
    it "increases quality by 1" do
      expect(item.quality).to eq(11)
    end
  end
  describe "one day update impact between 5 and 10 days away" do
    before do
      3.times{backstage_pass.update}
    end
    it "decreases sell_in by 1" do
      expect(item.sell_in).to eq(9)
    end
    it "increases quality by 2" do
      expect(item.quality).to eq(15)
    end
  end
  describe "one day update impact smaller than 5 days away" do
    before do
      8.times{backstage_pass.update}
    end
    it "decreases sell_in by 1" do
      expect(item.sell_in).to eq(4)
    end
    it "increases quality by 3" do
      expect(item.quality).to eq(27)
    end
  end
  describe "one day update impact AFTER sell_in date" do
    before do
      13.times{backstage_pass.update}
    end
    it "decreases sell_in by 1" do
      expect(item.sell_in).to eq(-1)
    end
    it "quality is zero after sell_in has passed" do
      expect(item.quality).to eq(0)
    end
  end
  # describe "max quality is 50" do
  #   it "imax quality is 50" do
  #     # items << Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=15, quality=49)
  #     2.times{backstage_pass.update_quality}
  #     expect(backstage_pass.quality).to eq(50)
  #   end
  # end

end
