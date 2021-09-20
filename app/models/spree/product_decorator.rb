module Spree
  module ProductDecorator
    def self.prepended(base)
      def base.ascend_by_postcode(postcode)
        vend_array = Spree::Vendor.near(postcode)

        tabl = vend_array.map.with_index { |vendor, index| "WHEN spree_products.vendor_id = '#{vendor.id}' THEN #{index}" }
        order_sql = "CASE #{tabl.join(' ')} ELSE #{tabl.size} END  ASC"

        joins(master: :default_price).order(Arel.sql(order_sql))
      end

      base.search_scopes << :ascend_by_postcode
    end
  end
end
::Spree::Product.prepend Spree::ProductDecorator if ::Spree::Product.included_modules.exclude?(Spree::ProductDecorator)
