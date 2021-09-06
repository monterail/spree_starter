module SpreeStarter
  module Spree
    module VendorDecorator
      def self.prepended(base)
        base.attr_accessor :postcode

        base.geocoded_by :coordinates
        base.after_validation :geocode
      end

      def coordinates
        [about_us].compact.join(', ')
      end
    end
  end
end

::Spree::Vendor.prepend SpreeStarter::Spree::VendorDecorator if ::Spree::Vendor.included_modules.exclude?(SpreeStarter::Spree::VendorDecorator)
