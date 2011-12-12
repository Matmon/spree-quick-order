Spree::BaseHelper.module_eval do

  def quick_order_form(rows = 3, *args, &b)
    
    opt        = args.extract_options!
    fid        = opt.fetch(:id)    { '' }
    fclass     = opt.fetch(:class) { 'spree_quick_order_fieldset' }

    render :partial => 'quick_order/form', :locals => { :rows => rows, :fid => fid, :fclass => fclass }
    
  end

end
