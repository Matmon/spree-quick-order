Spree::Core::Engine.routes.append do
  match "quick-order" => "quick_order#index", :via => :get
  match "quick-order" => "quick_order#sku_populate_cart", :via => :post,
    :as => "sku_populate_cart"
end
