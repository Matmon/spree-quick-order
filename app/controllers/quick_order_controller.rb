class QuickOrderController < Spree::BaseController
  helper :products
  respond_to :html
  
  def index
    #should list empty form

  end

  def sku_populate_cart
  	#should find product variants by sku and add/populate the order. then redirect to cart
  	@order = current_order(true)
    logger.debug @order.inspect

    @bulk_order = ::SpreeQuickOrder::BulkPopulateOrder.new(@order, params[:quickcartrows])

    logger.debug "SKU BULK ORDER"
    logger.debug @bulk_order.error_messages

    @order = @bulk_order.bulk_order
   # flash[:error] = @bulk_order.error_messages.join('<br>').html_safe if @bulk_order.has_error_messages?
    flash[:error] = @bulk_order.formatted_error_messages  if @bulk_order.has_error_messages?

    logger.debug @order.inspect
=begin

     params[:quickcartrows].each do |k, v|
       #logger.debug v.inspect
       variant_sku = v[:sku].strip
       #logger.debug variant_sku.inspect
       quantity = v[:quantity].to_i
       product_variant = Variant.find_by_sku(variant_sku) unless variant_sku.empty?
       #logger.debug product_variant.inspect
       #logger.debug product_variant.nil?

       @order.add_variant(product_variant, quantity) if quantity > 0 && !product_variant.nil? && product_variant.available?
       
       #flash[:error] = "Product SKU #{variant_sku} Not Found" if !variant_sku.empty? && product_variant.nil?
     end if params[:quickcartrows]

=end

#logger.debug @order.inspect
  fire_event('spree.cart.add')
  fire_event('spree.order.contents_changed')
  respond_with(@order) { |format| format.html { redirect_to cart_path } }
  end

end
