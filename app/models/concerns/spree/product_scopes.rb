module Spree
  module ProductDecorator
    def self.prepended(base)
      def base.ascend_by_postcode
        #     # sort vendors in the order closest to the given postcode
        vend_array = Spree::Vendor.near([52.3863596, 16.8195344])

        #     # based on vendors array generate order SQL
        tabl = vend_array.map.with_index { |vendor, index| "WHEN spree_products.vendor_id = '#{vendor.id}' THEN #{index}" }
        order_sql = "CASE #{tabl.join(' ')} ELSE #{tabl.size} END  ASC"

        #     joins(master: :default_price).order(Arel.sql(order_sql))
        joins(master: :default_price).order(Arel.sql(order_sql))
      end

      base.search_scopes << :ascend_by_postcode
    end
  end
end
::Spree::Product.prepend Spree::ProductDecorator if ::Spree::Product.included_modules.exclude?(Spree::ProductDecorator)
