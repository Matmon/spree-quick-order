module SpreeQuickOrder
  class BulkPopulateOrder
    include ActionView::Helpers::TagHelper

    # Accepts the current spree order object and the rows sku params
    # checks if each sku is valid and adds to order
    # otherwise sets error messages

    def initialize(order, cartrows)
      @rows = Hash[Array(cartrows)]
      @error_messages = []
      @rows.delete_if { |k,v| v[:sku].empty? }

      if @rows.size > 0
        @rows.each do |k, v|
          variant_sku = v[:sku].strip
          quantity = v[:quantity].to_i

          # unless variant_sku.empty?
          ## should no longer be empty since we delete empty rows above
          product_variant = Spree::Variant.find_by_sku(variant_sku)
          v[:variant] = product_variant

          if product_variant.nil?
            v[:error] = true
            @error_messages << "SKU Not Found: #{variant_sku}"
          end

          if quantity < 1
            v[:error] = true
            @error_messages << "Enter a Valid Quantity for SKU: #{variant_sku}"
          end

        end

        ## no errors add product variants to order
        @rows.each do |k , v|
          order.add_variant(v[:variant], v[:quantity].to_i)
        end unless self.has_error_messages?

      else
        @error_messages << "You Must Enter at least one Product SKU"
      end
    end

    def rows
      return @rows
    end

    def has_rows?
      return @rows.size > 0
    end

    def bulk_order
      return @bulk_order
    end

    def error_messages
      return @error_messages
    end

    def formatted_error_messages
      @error_messages.map do |e|
        content_tag(:li, e)
      end.join("\n").html_safe()
    end

    def has_error_messages?
      return !@error_messages.empty?
    end
  end
end
