module SpreeStarter
  module Spree
    module AddressDecorator
      def self.prepended(base)
        base.attr_accessor :postcode

        base.geocoded_by :coordinates
        base.after_validation :geocode
      end

      def coordinates
        [address1, address2, city, zipcode].compact.join(', ')
      end
    end
  end
end

::Spree::Address.prepend SpreeStarter::Spree::AddressDecorator if ::Spree::Address.included_modules.exclude?(SpreeStarter::Spree::AddressDecorator)


