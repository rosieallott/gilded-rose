require 'gilded_rose'

describe GildedRose do
  subject(:gilded_rose) { described_class.new(items) }
  let(:items) {[]}

  describe "OTHER ITEM original master tests" do
    describe "one day update impact before or on sell_in date" do
      before do
        items << Item.new(name="anything else", sell_in=4, quality=10)
        gilded_rose.update
      end
      it "decreases sell_in by 1" do
        expect(items[0].sell_in).to eq(3)
      end
      it "decreases quality by 1" do
        expect(items[0].quality).to eq(9)
      end
      it "decreases quality by 1 ON sell_in date" do
        3.times{gilded_rose.update}
        expect(items[0].quality).to eq(6)
      end
    end
    describe "one day update impact AFTER sell_in date" do
      before do
        items << Item.new(name="anything else", sell_in=4, quality=10)
        5.times{gilded_rose.update}
      end
      it "decreases quality by 2 now" do
        expect(items[0].quality).to eq(4)
      end
      it "decreases sell_in by 1 still" do
        expect(items[0].sell_in).to eq(-1)
      end
    end
  end

  describe "CONJURED ITEMS original master tests" do
    describe "one day update impact before or on sell_in date" do
      before do
        items << Item.new(name="Conjured Mana Cake", sell_in=4, quality=20)
        gilded_rose.update
      end
      it "decreases sell_in by 1" do
        expect(items[0].sell_in).to eq(3)
      end
      it "decreases quality by 2" do
        expect(items[0].quality).to eq(18)
      end
      it "decreases quality by 2 ON sell_in date" do
        3.times{gilded_rose.update}
        expect(items[0].quality).to eq(12)
      end
    end
    describe "one day update impact AFTER sell_in date" do
      before do
        items << Item.new(name="Conjured Mana Cake", sell_in=4, quality=20)
        5.times{gilded_rose.update}
      end
      it "decreases sell_in by 1 still" do
        expect(items[0].sell_in).to eq(-1)
      end
      it "decreases quality by 2 now" do
        expect(items[0].quality).to eq(8)
      end
      it "cannot decrease quality below 0" do
        21.times{gilded_rose.update}
        expect(items[0].quality).to eq(0)
      end
    end
  end

  describe "AGED BRIE original master tests" do
    describe "one day update impact before or on sell_in date" do
      before do
        items << Item.new(name="Aged Brie", sell_in=4, quality=20)
        gilded_rose.update
      end
      it "decreases sell_in by 1" do
        expect(items[0].sell_in).to eq(3)
      end
      it "increases quality by 1" do
        expect(items[0].quality).to eq(21)
      end

    end
    describe "one day update impact AFTER sell_in date" do
      before do
        items << Item.new(name="Aged Brie", sell_in=4, quality=20)
        5.times{gilded_rose.update}
      end
      it "still increases quality by 1" do
        expect(items[0].quality).to eq(26)
      end
      it "decreases sell_in by 1 still" do
        expect(items[0].sell_in).to eq(-1)
      end
      it "50 is maximum quality" do
        20.times{gilded_rose.update}
        expect(items[0].quality).to eq(50)
      end
    end
  end

  describe "SULFURAS original master tests" do
    describe "one day update impact" do
      before do
        items << Item.new(name="Sulfuras, Hand of Ragnaros", sell_in=0, quality=10)
        gilded_rose.update
      end
      it "no sell_in date" do
        expect(items[0].sell_in).to eq(0)
      end
      it "quality remains the same" do
        expect(items[0].quality).to eq(10)
      end
      it "quality always remains the same" do
        5.times{gilded_rose.update}
        expect(items[0].quality).to eq(10)
      end
    end
  end

  describe "BACKSTAGE PASSES original master tests" do
    describe "one day update impact > 10 days away" do
      before do
        items << Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=12, quality=10)
        gilded_rose.update
      end
      it "increases quality by 1" do
        expect(items[0].quality).to eq(11)
      end
      it "decreases sell_in by 1" do
        expect(items[0].sell_in).to eq(11)
      end
    end
    describe "one day update impact between 5 and 10 days away" do
      before do
        items << Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=12, quality=10)
        3.times{gilded_rose.update}
      end
      it "increases quality by 2" do
        expect(items[0].quality).to eq(15)
      end
      it "decreases sell_in by 1" do
        expect(items[0].sell_in).to eq(9)
      end
    end
    describe "one day update impact smaller than 5 days away" do
      before do
        items << Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=12, quality=10)
        8.times{gilded_rose.update}
      end
      it "increases quality by 3" do
        expect(items[0].quality).to eq(27)
      end
      it "decreases sell_in by 1" do
        expect(items[0].sell_in).to eq(4)
      end
    end
    describe "one day update impact AFTER sell_in date" do
      before do
        items << Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=12, quality=10)
        13.times{gilded_rose.update}
      end
      it "decreases sell_in by 1" do
        expect(items[0].sell_in).to eq(-1)
      end
      it "quality is zero after sell_in has passed" do
        expect(items[0].quality).to eq(0)
      end
    end
    describe "max quality is 50" do
      it "imax quality is 50" do
        items << Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=15, quality=49)
        3.times{gilded_rose.update}
        expect(items[0].quality).to eq(50)
      end
    end
  end

end
