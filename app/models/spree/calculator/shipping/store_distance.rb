require 'pry'
module Spree
  module Calculator::Shipping
    class StoreDistance < ShippingCalculator

      def available?(object)
        object.currency == "GBP"
      end

      def self.description
        Spree.t(:shipping_store_distance)
      end

      def compute_package(package)
        compute_from_distance(package)
      end

      def compute_from_distance(_package)

        vendors = _package.order.variants.map do |vend|
          vend.vendor.to_coordinates
        end

        total = 0

        start = _package.to_shipment.stock_location.to_coordinates
        total += Geocoder::Calculations.distance_between(start, vendors[0])

        n = 1
        x = vendors.count - 1
        for a in n...x
          distance = Geocoder::Calculations.distance_between(vendors[n], vendors[n - 1])
          total += distance
        end

        final_location = _package.order.ship_address.to_coordinates
        total += Geocoder::Calculations.distance_between(vendors.last, final_location)

        total += Geocoder::Calculations.distance_between(final_location, start)

        store_collection_charge = vendors.count * 0.5

        case total
        when 0..2.5
          1
        when 2.6..3.5
          2
        when 3.6..5.9
          3
        when 6.0..9
          4
        end

        total_weight = 0
        weight_co_efficient = _package.order.variants.all.count
        x = weight_co_efficient.count

        for b in 0...x do
          total_weight = _package.order.variants.map do |all|
            all.weight
          end
        end
        total_weight.sum
        
      end
    end
  end
end
