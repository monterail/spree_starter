module SpreeStarter
    module Spree
        module ProductSortingDecorator
            def self.prepend(base)
                base.attr_accessor :postcode

                base.geocoded_by :coordinates
                base.after_validation :geocode
            end

            def coordinates
                [postcode, about_us, address1, address2, city, zipcode].compact.join(', ')
            end

            def sort_by_postcode
                resoult = Spree::User.first.addresses
                Spree::Vendor.near(resoult)
            end
        end
    end
end
