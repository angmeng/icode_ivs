class PurchaseOrderHistoriesController < ApplicationController
  # GET /purchase_order_histories
  # GET /purchase_order_histories.xml
  def index
    @search = PurchaseOrderHistory.search(params[:search])
    @purchase_order_histories = @search.all.paginate(:page => params[:page], :per_page => 15)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @purchase_order_histories }
    end
  end

  # GET /purchase_order_histories/1
  # GET /purchase_order_histories/1.xml
  def show
    @purchase_order_history = PurchaseOrderHistory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @purchase_order_history }
    end
  end

  # GET /purchase_order_histories/new
  # GET /purchase_order_histories/new.xml
  def new
    @purchase_order_history = PurchaseOrderHistory.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @purchase_order_history }
    end
  end

  # GET /purchase_order_histories/1/edit
  def edit
    @purchase_order_history = PurchaseOrderHistory.find(params[:id])
  end

  # POST /purchase_order_histories
  # POST /purchase_order_histories.xml
  def create
    @purchase_order_history = PurchaseOrderHistory.new(params[:purchase_order_history])

    respond_to do |format|
      if @purchase_order_history.save
        format.html { redirect_to(@purchase_order_history, :notice => 'PurchaseOrderHistory was successfully created.') }
        format.xml  { render :xml => @purchase_order_history, :status => :created, :location => @purchase_order_history }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @purchase_order_history.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /purchase_order_histories/1
  # PUT /purchase_order_histories/1.xml
  def update
    @purchase_order_history = PurchaseOrderHistory.find(params[:id])

    respond_to do |format|
      if @purchase_order_history.update_attributes(params[:purchase_order_history])
        format.html { redirect_to(@purchase_order_history, :notice => 'PurchaseOrderHistory was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @purchase_order_history.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /purchase_order_histories/1
  # DELETE /purchase_order_histories/1.xml
  def destroy
    @purchase_order_history = PurchaseOrderHistory.find(params[:id])
    @purchase_order_history.destroy

    respond_to do |format|
      format.html { redirect_to(purchase_order_histories_url) }
      format.xml  { head :ok }
    end
  end
end
