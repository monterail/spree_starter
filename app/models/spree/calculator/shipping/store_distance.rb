require 'pry'
require_dependency 'spree/shipping_calculator'
module Spree
  module Calculator::Shipping
    class StoreDistance < Spree::ShippingCalculator

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

        store_collection_charge = -0.5
        vendors.map { |store_charge| store_collection_charge += 0.5 }

        case total
        when 0..2.5
          total = 2.5
        when 2.6..3.5
          total = 3.5
        when 3.6..5.9
          total = 4.5
        when 6.0..9
          total = 5.5
        end


        total_weight = 0
        x = _package.order.variants.all.count

        for b in 0...x do
          total_weight = _package.order.variants.map do |all|
            all.weight
          end
        end
        total_load = total_weight.sum

        case total_load
        when 0..25
          total_load = 1
        when 26..36
          total_load = 1.2
        when 36..50
          total_load = 1.4
        end

        total = total + store_collection_charge
        total_price = (total * total_load)
      end
    end
  end
end
