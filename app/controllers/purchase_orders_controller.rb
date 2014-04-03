class PurchaseOrdersController < ApplicationController
  before_filter :authenticated_admin, :except => [:received, :index]
  before_filter :authenticated_admin_and_user, :only => [:received, :index]
  before_filter :set_locale

   uses_tiny_mce :only => [:edit_remark],
                :options => {
                        :theme => 'advanced',
                        :theme_advanced_resizing => true,
                        :theme_advanced_resize_horizontal => false,
                        :plugins => %w{ table fullscreen safari spellchecker pagebreak style layer save advhr advimage advlink emotions iespell inlinepopups insertdatetime preview media searchreplace print contextmenu paste directionality noneditable visualchars nonbreaking xhtmlxtras template },

               :theme_advanced_buttons1 => %w{ save newdocument | bold italic underline strikethrough | justifyleft justifycenter justifyright justifyfull | styleselect formatselect fontselect fontsizeselect },
               :theme_advanced_buttons2 => %w{ cut copy paste pastetext pasteword | search replace | bullist numlist | outdent indent blockquote | undo redo | link unlink anchor image cleanup help code | insertdate inserttime preview | forecolor backcolor },
               #:theme_advanced_buttons3 => %w{ tablecontrols | hr removeformat visualaid | sub sup | charmap emotions iespell media advhr | print | ltr rtl | fullscreen },
               #:theme_advanced_buttons4 => %w{ insertlayer moveforward movebackward absolute | styleprops spellchecker | cite abbr acronym del ins attribs | visualchars nonbreaking template blockquote pagebreak | insertfile insertimage },
               :theme_advanced_toolbar_location => "top",
               :theme_advanced_toolbar_align => "left",
               :theme_advanced_statusbar_location => "bottom"
                 }
                 
  # GET /purchase_orders
  # GET /purchase_orders.xml
  def index
    @search = PurchaseOrder.search(params[:search])
    @purchase_orders = @search.all(:order => "purchase_order_date DESC").uniq.paginate(:page => params[:page], :per_page => 30)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @purchase_orders }
    end
  end

  def show_product
    @products = Product.all(:conditions => ['code LIKE ?', "#{params[:search]}%"])
    @products.each {|c|
       c.code = c.code_name
    }
  end

  # GET /purchase_orders/1
  # GET /purchase_orders/1.xml
  def show
    @purchase_order = PurchaseOrder.find(params[:id])
    @products = Product.all(:order => "code, name")
    @terms = Term.options
    @current_items = @purchase_order.purchase_order_items.all(:joins => :purchase_requisition_item, :order => "purchase_requisition_items.sequence_number").paginate(:page => params[:page], :per_page => 20)

  
  end

  def update_info
    @purchase_order = PurchaseOrder.find(params[:id])
    @purchase_order.update_attributes(params[:purchase_order])
    flash[:notice] = "Update Completed"
    redirect_to @purchase_order
    
  end

  # GET /purchase_orders/new
  # GET /purchase_orders/new.xml
  def new
    @purchase_order = PurchaseOrder.new
    @products = Product.all(:order => "code, name")
    #@locations = StoreLocation.all(:order => "name")
    1.upto(3) { @purchase_order.purchase_order_items.build }

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @purchase_order }
    end
  end

  # GET /purchase_orders/1/edit
  def edit
    @purchase_order = PurchaseOrder.find(params[:id])
    @suppliers = Supplier.all(:order => "name")
    @projects = Project.options
  end

  # POST /purchase_orders
  # POST /purchase_orders.xml
  def create
    @purchase_order = PurchaseOrder.new(params[:purchase_order])

    @products = Product.all(:order => "name")
    @purchase_order.generate_order_number
    if @purchase_order.save
      Setting.increment_of_purchase_order
      flash[:notice] = (t "flashes.successfully_created")
      redirect_to @purchase_order
    else
      render :action => 'new'
    end
  end

  def received
    @purchase_order = PurchaseOrder.find(params[:id])
    @current_items = GoodsReceiving.new(@purchase_order).items
  end

  # def pending
  #   @purchase_order = PurchaseOrder.find(params[:id])
  #   @purchase_order.goods_receive_notes
  # end
  
  def complete
    purchase_order = PurchaseOrder.find(params[:id])
    purchase_order.mark_as_completed
    flash[:notice] = (t "flashes.successfully_updated")
    redirect_to purchase_order
  end
  
  def submit_pricing
    purchase_order = PurchaseOrder.find(params[:id])
    if params[:commit] == "Update"
      params[:pricing] ||= []

      params[:pricing].each {|p_id, content|
      pricing = purchase_order.purchase_order_items.find(p_id.to_i) rescue nil
      pricing.unit_price = content[:amount].to_f rescue 0.00
      pricing.save!
      }
    elsif params[:commit] == "Remove Selected"
      params[:item] ||= []

      params[:item].each {|p_id, content|
      item = purchase_order.purchase_order_items.find(p_id.to_i) rescue nil
      item.destroy if content[:selected].to_i == 1
      }
    end

    flash[:notice] = "Update completed"
    redirect_to(purchase_order)
  end
  
  def add_items
    if is_admin?
      @purchase_order = PurchaseOrder.find(params[:id])
      @purchase_order.add_order_items(params[:purchase_order_item])
    
      flash[:notice] = "Operation Completed"
      redirect_to @purchase_order
    else
      flash[:error] = "You cannot access this area"
      redirect_to :action => "index"
    end
  end
  

  # PUT /purchase_orders/1
  # PUT /purchase_orders/1.xml
  def update
    @purchase_order = PurchaseOrder.find(params[:id])

    respond_to do |format|
      if @purchase_order.update_attributes(params[:purchase_order])
        flash[:notice] = (t "flashes.successfully_updated")
        format.html { redirect_to(@purchase_order) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @purchase_order.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def void
    @purchase_order = PurchaseOrder.find(params[:id])
    @purchase_order.void = true
    @purchase_order.save
    flash[:notice] = (t "flashes.successfully_voided")
    redirect_to purchase_invoices_url
  end

  # DELETE /purchase_orders/1
  # DELETE /purchase_orders/1.xml
  def destroy
    @purchase_order = PurchaseOrder.find(params[:id])
    if @purchase_order.verify_for_destroy
      flash[:notice] = (t "flashes.successfully_destroyed")
    else
      flash[:error] = (t "flashes.cannot_destroy_pls_use_void")
    end

    respond_to do |format|
      format.html { redirect_back_or_default(purchase_orders_url) }
      format.xml  { head :ok }
    end
  end
  
  def remove_item
    @purchase_order = PurchaseOrder.find(params[:id])
    @purchase_order.purchase_order_items.find(params[:purchase_order_item_id]).destroy
    flash[:notice] = (t "flashes.successfully_removed")
    redirect_to(@purchase_order)
    
  end
  
  def preview
    @number_rows = params[:number_rows].blank? ?  18 : params[:number_rows].to_i
    @purchase_order = PurchaseOrder.find(params[:id])
    @items = @purchase_order.purchase_order_items.all(:joins => :purchase_requisition_item, :order => "purchase_requisition_items.sequence_number")
    @currency = @purchase_order.currency
    render :layout => false
  end

  def edit_remark
    @item = PurchaseOrderItem.find(params[:id])
    @po = @item.purchase_order
  end

  def update_remark
    @purchase_order = PurchaseOrder.find(params[:id])
    params[:item].each do |item_id, content|
      item = @purchase_order.purchase_order_items.find(item_id.to_i)
      item.remark = content[:remark]
      item.save!
    end
    flash[:notice] = "Update Completed"
    redirect_to @purchase_order
  end
  
end
