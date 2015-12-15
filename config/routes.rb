ActionController::Routing::Routes.draw do |map|
  map.resources :accessible_menus
  map.resources :purchase_order_histories
  map.resources :reserved_purchase_orders
  map.resources :project_supervisors
  map.resources :terms
  map.connect 'return_notes/search_by_category', :controller => "return_notes", :action => "search_by_category"
  map.resources :return_notes, :member => { :remove_item => :delete, :update_items => :post, :add_items => :post, :preview => :get}
  map.resources :transportation_slips, :member => {:preview => :get}
  map.resources :vehicles
  map.connect 'purchase_requisitions/replace_material_id', :controller => "purchase_requisitions", :action => "replace_material_id"
  map.connect 'purchase_requisitions/search_by_material', :controller => "purchase_requisitions", :action => "search_by_material"
  map.connect 'purchase_requisitions/search_by_category', :controller => "purchase_requisitions", :action => "search_by_category"
  map.resources :purchase_requisitions, :member => {:update_po => :post, :edit_remark => :get, :update_remark => :post, :remove_item => :delete, :generate => :get, :regenerate => :get, :send_for_approval => :get, :approve => :get, :void => :get, :edit_items => :post, :preview => :post, :add_items => :post}
  map.resources :purchase_orders, :member => {:received => :get, :pending => :get, :edit_remark => :get, :update_remark => :post, :update_info => :post, :submit_pricing => :post, :complete => :get, :void => :get, :remove_item => :get, :preview => :post, :add_items => :post},
                                  :collection => {:show_product => :get}

  map.resources :purchase_requisition_categories
  map.resources :projects
  map.resources :currencies
  map.resources :uoms
  map.resources :materials, :collection => {:show_options => :get}, :member => {:copy => :get}
  map.resources :material_groups
  map.resources :material_categories
  map.resources :product_groups
  #map.resources :goods_receive_note_items
  map.connect 'goods_receive_notes/update_items', :controller => "goods_receive_notes", :action => "update_items"
  map.resources :goods_receive_notes, :member => {:edit_remark => :get, :update_remark => :post, :unsettle_po => :get, :settle_po => :get, :settle => :get, :remove_item => :get, :show_items => :get, :import_items => :post },
                                      :collection => {:unsettled => :get}

  #map.resources :purchase_order_items
  map.resources :stock_transfers
  map.resources :commissions
  map.resources :salesmen, :member => {:edit_commission => :get, :submit_commission => :post}
  map.resources :customer_pricings
  map.resources :companies
  map.resources :document_categories
  map.resources :expenses
  map.resources :card_categories
  map.resources :banks
  map.resources :credit_cards
  map.resources :cheques,:collection => {:show_current_date_own => :get, :show_current_date_customer => :get, :show_future_own => :get, :show_future_customer => :get}
  map.resources :payment_methods
  map.connect '/supplier_payment/show_payment_info', :controller => 'supplier_payments', :action => 'show_payment_info'
  map.resources :supplier_payments
  map.connect '/customer_payment/show_payment_info', :controller => 'customer_payments', :action => 'show_payment_info'
  map.resources :customer_payments
  map.resources :stock_adjustments
  map.resources :stocks
  map.resources :store_locations, :member => {:update_balance => [:post, :get]}
  map.connect 'product_movements/search', :controller => "product_movements", :action => "search"
  map.resources :product_movements, :collection => {:search => :post}
  #map.resources :purchase_requisition_items
  map.resources :suppliers
  map.resources :departments, :member => {:assign_accessible => :post}
  #map.resources :invoice_items
  map.resources :invoices, :member => {:complete => :get, :submit_pricing => :post, :void => :get, :remove_item => :get, :preview => :get, :add_items => :post}
  map.resources :document_storages, :collection => {:category_index => :get}
  map.resources :settings
  map.resources :customers, :member => {:edit_pricing => :get, :submit_pricing => :post}
  map.resources :products, :member => {:update_uom => :post, :add_uom => :post, :remove_uom => :get, :add_location => :post, :remove_location => :get, :add_supplier => :post, :remove_supplier => [:get, :post]}
  map.resources :product_categories
  map.logout 'logout', :controller => 'sessions', :action => 'destroy'
  map.admin 'admin', :controller => 'sessions', :action => 'new'
  map.resources :sessions
  map.resources :users, :member => {:change_password => :get, :update_password => :post}
  map.home 'home', :controller => "home"
  map.connect 'report/:action/:id.:format', :controller => 'report'
  map.connect 'kawaii/:action/:id.:format', :controller => 'kawaii'
  map.connect 'home/:action/:id.:format', :controller => 'home'
  map.root :controller => 'home', :action => 'index'

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
   

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
end
