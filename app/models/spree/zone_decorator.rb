module SpreeStarter
  module Spree
    module ZoneDecorator
      def self.prepended(base)
        base.attr_accessor :postcode

        base.geocoded_by :coordinates
        base.after_validation :geocode
      end

      def coordinates
        [starting_point, address].compact.join(', ')
      end
    end
  end
end

::Spree::Zone.prepend SpreeStarter::Spree::ZoneDecorator if ::Spree::Zone.included_modules.exclude?(SpreeStarter::Spree::ZoneDecorator)

