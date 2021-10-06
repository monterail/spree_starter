module SpreeStarter
  module Spree
    module StockLocationDecorator
      def self.prepended(base)
        base.attr_accessor :postcode

        base.geocoded_by :coordinates
        base.after_validation :geocode
      end

      def coordinates
        [address1, address2, zipcode ].compact.join(', ')
      end
    end
  end
end

::Spree::StockLocation.prepend SpreeStarter::Spree::StockLocationDecorator if ::Spree::StockLocation.included_modules.exclude?(SpreeStarter::Spree::StockLocationDecorator)


