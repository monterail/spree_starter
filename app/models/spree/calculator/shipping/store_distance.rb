require 'pry'
require_dependency 'spree/shipping_calculator'

module Spree
  module Calculator::Shipping
    class StoreDistance < Spree::ShippingCalculator
      preference :base_amount_up_to_2_5_mi, :decimal, default: 2.5
      preference :base_amount_up_to_3_5_mi, :decimal, default: 3.5
      preference :base_amount_up_to_6_mi, :decimal, default: 4.5
      preference :base_amount_up_to_9_mi, :decimal, default: 5.5

      def self.description
        Spree.t(:shipping_store_distance)
      end

      def compute_package(package)
        compute_store_distance(package)
      end

      def vendors_coordinates(package)
        package.order.variants.map do |variant|
          variant.vendor.to_coordinates
        end
      end

      def total_product_weight(package)
        total_weight = package.order.variants.map do |variant|
          variant.weight
        end
        total_load = total_weight.inject(0) { |sum, number| sum + number }

        case total_load
        when 0..25 then total_load = 1
        when 26..36 then total_load = 1.2
        when 36..50 then total_load = 1.4
        end
      end

      def total_distance(package)
        vendor_co = vendors_coordinates(package)

        milage_price_band = 0

        vendor_co.unshift(package.stock_location.to_coordinates)
        vendor_co << package.order.ship_address.to_coordinates
        vendor_co << package.stock_location.to_coordinates

        vendor_co[0...-1].each_with_index do |val, index|
          milage_price_band += Geocoder::Calculations.distance_between(vendor_co[index], vendor_co[index + 1])
        end

        case milage_price_band
        when 0..2.5 then milage_price_band = 2.5
        when 2.6..3.5 then milage_price_band = 3.5
        when 3.6..5.9 then milage_price_band = 4.5
        when 6.0..9 then milage_price_band = 5.5
        else raise "We do not deliver further than 9 miles"
        end
      end

      def store_collection_charge(package)
        vendors_coordinates(package).inject(-0.5) { |sum, number| sum + 0.5 }
      end

      def compute_store_distance(package)
        binding.pry
        milage_price_band = total_distance(package)

        store_collection_charge(package)

        total_weight = total_product_weight(package)

        (milage_price_band * total_weight) + store_collection_charge(package)
      end
    end
  end
end
