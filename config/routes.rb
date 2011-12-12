Rails.application.routes.draw do
  # Add your extension routes here
  #get "quick_order/index"
  #post "quick_order/sku_populate_cart"

  match "quick-order" => "quick_order#index", :via => :get
  match "quick-order" => "quick_order#sku_populate_cart", :via => :post, :as => "sku_populate_cart"

end
