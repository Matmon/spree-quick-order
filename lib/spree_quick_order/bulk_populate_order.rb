module SpreeQuickOrder
	class BulkPopulateOrder
		include ActionView::Helpers::TagHelper
		#attr_reader :error_messages, :bulk_order 

		def initialize(order, cartrows)
			
			@error_messages = []
			if !cartrows.nil?
				cartrows.each do |k, v|
				       variant_sku = v[:sku].strip
				       quantity = v[:quantity].to_i
				       product_variant = Variant.find_by_sku(variant_sku) unless variant_sku.empty?

				       order.add_variant(product_variant, quantity) if quantity > 0 && !product_variant.nil? && product_variant.available?
				       
				       @error_messages << "Product SKU #{variant_sku} Not Found" if !variant_sku.empty? && product_variant.nil?
			    end 
			else
				@error_messages << "You Must Enter a Product SKU"
			end
			
			@bulk_order = order 

			#@bulk_order = {:order => order, :error_messages => @error_messages}

			#return @bulk_order

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