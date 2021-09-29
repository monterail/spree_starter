require 'spec_helper'

module Spree
  module Calculator::Shipping
    describe StoreDistance, type: :model do
      let(:subject) { StoreDistance.new }

      let(:variant1) { build(:variant, price: 19) }
      let(:variant2) { build(:variant, price: 25) }

      let(:package) do
        build(:stock_package, variants_contents: {variant1 => 5})
      end
      let!(:vendor) { Spree::Vendor.create!(name: "vendor1", about_us: "50 Newton St, Birmingham B4 6NE") }
      let!(:vendor2) { Spree::Vendor.create!(name: "vendor2", about_us: "Ryder St, Birmingham B4 7NE") }

      let(:stock_location1) { build(:stock_location) }

      let(:line_item1) { build(:line_item, variant1: variant1) }
      let(:line_item2) { build(:line_item, variant2: variant2) }

      it 'returns address' do
        expect(subject.compute(package)).to eq(0)
      end

      it 'return vendor' do
        expect(vendor.to_coordinates).to eq(Spree::Vendor.first.to_coordinates)
      end

      it 'allows creation of new object with all the attributes' do
        StoreDistance.new(
          preferred_base_amount_up_to_2_5_mi: 1,
          preferred_base_amount_up_to_3_5_mi: 2,
          preferred_base_amount_up_to_6_mi: 3,
          preferred_base_amount_up_to_9_mi: 4
        )
      end
    end
  end
end
