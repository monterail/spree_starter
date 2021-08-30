module SpreeStarter
    module Spree
      module UserDecorator
        def self.prepended(base)
          base.attr_accessor :addresses

          base.geocoded_by :coordinates
          base.after_validation :geocode
        end

        def coordinates
          [latitude, longitude].compact.join(', ')
        end
      end
    end
  end

  ::Spree::User.prepend SpreeStarter::Spree::UserDecorator if ::Spree::User.included_modules.exclude?(SpreeStarter::Spree::UserDecorator)
