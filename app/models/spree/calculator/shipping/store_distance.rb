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
        total_weight = 0

        total_weight = package.order.variants.map do |variant|
          variant.weight
        end
        total_weight.sum
      end

      def total_distance(package)
        vendor_co = vendors_coordinates(package)

        total_distance = 0

        total_distance += Geocoder::Calculations.distance_between(package.stock_location.to_coordinates, vendor_co[0])

        vendor_co[0...-1].each_with_index do |val, index|
          total_distance += Geocoder::Calculations.distance_between(vendor_co[index], vendor_co[index + 1])
        end

        total_distance += Geocoder::Calculations.distance_between(vendor_co.last, package.order.ship_address.to_coordinates)

        total_distance += Geocoder::Calculations.distance_between(package.order.ship_address.to_coordinates, package.stock_location.to_coordinates)
      end

      def store_collection_charge(package)
        vendor_co = vendors_coordinates(package)
        vendor_co.inject(-0.5) { |sum, number| sum + 0.5}
      end

      def compute_store_distance(package)
        binding.pry

        milage_price_band = total_distance(package)

        case milage_price_band
        when 0..2.5
          milage_price_band = base_amount_up_to_2_5_mi
        when 2.6..3.5
          milage_price_band = base_amount_up_to_3_5_mi
        when 3.6..5.9
          milage_price_band = preferred_base_amount_up_to_6_mi
        when 6.0..9
          milage_price_band = preferred_base_amount_up_to_9_mi
        end

        scc = store_collection_charge(package)

        total_weight = total_product_weight(package)

        case total_weight
        when 0..25
          total_weight = 1
        when 26..36
          total_weight = 1.2
        when 36..50
          total_weight = 1.4
        end

        total_price = (milage_price_band * total_weight) + scc
      end
    end
  end
end
