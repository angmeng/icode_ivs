class ReservedPurchaseOrdersController < ApplicationController
  before_filter :authenticated_admin_and_user
  before_filter :set_locale
  # GET /reserved_purchase_orders
  # GET /reserved_purchase_orders.xml
  def index
    @reserved_purchase_orders = ReservedPurchaseOrder.all(:order => "purchase_order_id DESC").paginate(:page => params[:page], :per_page => 20)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reserved_purchase_orders }
    end
  end

  # GET /reserved_purchase_orders/1
  # GET /reserved_purchase_orders/1.xml
  def show
    @reserved_purchase_order = ReservedPurchaseOrder.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @reserved_purchase_order }
    end
  end

  # GET /reserved_purchase_orders/new
  # GET /reserved_purchase_orders/new.xml
  def new
    @reserved_purchase_order = ReservedPurchaseOrder.new
    if @reserved_purchase_order.generate_order_number

      flash[:notice] = "PO No generated"
      redirect_to @reserved_purchase_order
    else
      flash[:error] = "Error generating PO No"
      redirect_to :action => "index"
    end
  end

  # GET /reserved_purchase_orders/1/edit
  def edit
    @reserved_purchase_order = ReservedPurchaseOrder.find(params[:id])
  end

  # POST /reserved_purchase_orders
  # POST /reserved_purchase_orders.xml
  def create
    @reserved_purchase_order = ReservedPurchaseOrder.new(params[:reserved_purchase_order])

    respond_to do |format|
      if @reserved_purchase_order.save
        format.html { redirect_to(@reserved_purchase_order, :notice => 'ReservedPurchaseOrder was successfully created.') }
        format.xml  { render :xml => @reserved_purchase_order, :status => :created, :location => @reserved_purchase_order }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @reserved_purchase_order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /reserved_purchase_orders/1
  # PUT /reserved_purchase_orders/1.xml
  def update
    @reserved_purchase_order = ReservedPurchaseOrder.find(params[:id])

    respond_to do |format|
      if @reserved_purchase_order.update_attributes(params[:reserved_purchase_order])
        format.html { redirect_to(@reserved_purchase_order, :notice => 'ReservedPurchaseOrder was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @reserved_purchase_order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /reserved_purchase_orders/1
  # DELETE /reserved_purchase_orders/1.xml
  def destroy
    @reserved_purchase_order = ReservedPurchaseOrder.find(params[:id])
    @reserved_purchase_order.destroy

    respond_to do |format|
      format.html { redirect_to(reserved_purchase_orders_url) }
      format.xml  { head :ok }
    end
  end
end
