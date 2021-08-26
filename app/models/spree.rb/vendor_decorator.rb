module Spree
    module VendorDecorator
      attr_accessor :postcode

      def coordinates
        [postcode, about_us].compact.join(', ')
      end

      geocoded_by :coordinates
      after_validation :geocode

    end
  end

  Spree::Vendor.prepend Spree::VendorDecorator
