require 'spree/calculator'

module Spree
  class Calculator::StoreDistance < Calculator
    preference :base_amount_up_to_2_5_mi, :decimal, default: 0
    preference :base_amount_up_to_3_5_mi, :decimal, default: 0
    preference :base_amount_up_to_6_mi, :decimal, default: 0
    preference :base_amount_up_to_9_mi, :decimal, default: 0

    def self.description
      Spree.t(:store_distance)
    end

    def self.available?(_object)
      true
    end

    def compute(object)
      compute_store_distance(object.distance)
    end


    def compute_store_distance(distance)
      vendors = distance.order.variants.map do |vend|
        vend.vendor.to_coordinates
      end

      total = 0

      start = distance.to_shipment.stock_location.to_coordinates
      total += Geocoder::Calculations.distance_between(start, vendors[0])

      n = 1
      x = vendors.count - 1
      for a in n...x
        vendor_distance = Geocoder::Calculations.distance_between(vendors[n], vendors[n - 1])
        total += vendor_distance
      end

      final_location = distance.order.ship_address.to_coordinates
      total += Geocoder::Calculations.distance_between(vendors.last, final_location)

      total += Geocoder::Calculations.distance_between(final_location, start)

      store_collection_charge = -0.5
      vendors.map { |store_charge| store_collection_charge += 0.5 }

      case total
      when 0..2.5
        total = preferred_base_amount_up_to_2_5_mi
      when 2.6..3.5
        total = preferred_base_amount_up_to_3_5_mi
      when 3.6..5.9
        total = preferred_base_amount_up_to_6_mi
      when 6.0..9
        total = preferred_base_amount_up_to_9_mi
      end

      total_weight = 0
      x = distance.order.variants.all.count

      for b in 0...x do
        total_weight = distance.order.variants.map do |all|
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
