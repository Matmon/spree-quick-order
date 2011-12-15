class QuickOrderController < Spree::BaseController
  helper :products
  respond_to :html
  
  def index
    #should list empty form

  end

  def sku_populate_cart
  	#should find product variants by sku and add/populate the order. then redirect to cart
  	@order = current_order(true)
    @bulk_order = ::SpreeQuickOrder::BulkPopulateOrder.new(@order, params[:quickcartrows])

    @order = @bulk_order.bulk_order
    flash[:error] = @bulk_order.formatted_error_messages if @bulk_order.has_error_messages?
    fire_event('spree.cart.add')
    fire_event('spree.order.contents_changed')
    respond_with(@order) { |format| format.html { redirect_to cart_path } }
  end

end
