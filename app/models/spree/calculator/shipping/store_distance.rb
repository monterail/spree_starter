require 'pry'
require_dependency 'spree/shipping_calculator'

module Spree
  module Calculator::Shipping
    class StoreDistance < Spree::ShippingCalculator
      preference :base_amount_up_to_2_5_mi, :decimal, default: 0
      preference :base_amount_up_to_3_5_mi, :decimal, default: 0
      preference :base_amount_up_to_6_mi, :decimal, default: 0
      preference :base_amount_up_to_9_mi, :decimal, default: 0

      def self.description
        Spree.t(:shipping_store_distance)
      end

      def compute_package(package)
        compute_store_distance(package)
      end

      delegate :compute_store_distance, to: :distance_calculator

      private

      def distance_calculator
        ::Spree::Calculator::StoreDistance.new(
          preferred_base_amount_up_to_2_5_mi: preferred_base_amount_up_to_2_5_mi,
          preferred_base_amount_up_to_3_5_mi: preferred_base_amount_up_to_3_5_mi,
          preferred_base_amount_up_to_6_mi: preferred_base_amount_up_to_6_mi,
          preferred_base_amount_up_to_9_mi: preferred_base_amount_up_to_9_mi
        )
      end
    end
  end
end
