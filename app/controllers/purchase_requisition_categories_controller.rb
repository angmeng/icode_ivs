class PurchaseRequisitionCategoriesController < ApplicationController
  before_filter :authenticated_admin
  before_filter :set_locale
  # GET /purchase_requisition_categories
  # GET /purchase_requisition_categories.xml
  def index
    @purchase_requisition_categories = PurchaseRequisitionCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @purchase_requisition_categories }
    end
  end

  # GET /purchase_requisition_categories/1
  # GET /purchase_requisition_categories/1.xml
  def show
    @purchase_requisition_category = PurchaseRequisitionCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @purchase_requisition_category }
    end
  end

  # GET /purchase_requisition_categories/new
  # GET /purchase_requisition_categories/new.xml
  def new
    @purchase_requisition_category = PurchaseRequisitionCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @purchase_requisition_category }
    end
  end

  # GET /purchase_requisition_categories/1/edit
  def edit
    @purchase_requisition_category = PurchaseRequisitionCategory.find(params[:id])
  end

  # POST /purchase_requisition_categories
  # POST /purchase_requisition_categories.xml
  def create
    @purchase_requisition_category = PurchaseRequisitionCategory.new(params[:purchase_requisition_category])

    respond_to do |format|
      if @purchase_requisition_category.save
        format.html { redirect_to(@purchase_requisition_category, :notice => 'PurchaseRequisitionCategory was successfully created.') }
        format.xml  { render :xml => @purchase_requisition_category, :status => :created, :location => @purchase_requisition_category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @purchase_requisition_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /purchase_requisition_categories/1
  # PUT /purchase_requisition_categories/1.xml
  def update
    @purchase_requisition_category = PurchaseRequisitionCategory.find(params[:id])

    respond_to do |format|
      if @purchase_requisition_category.update_attributes(params[:purchase_requisition_category])
        format.html { redirect_to(@purchase_requisition_category, :notice => 'PurchaseRequisitionCategory was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @purchase_requisition_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /purchase_requisition_categories/1
  # DELETE /purchase_requisition_categories/1.xml
  def destroy
    @purchase_requisition_category = PurchaseRequisitionCategory.find(params[:id])
    @purchase_requisition_category.destroy

    respond_to do |format|
      format.html { redirect_to(purchase_requisition_categories_url) }
      format.xml  { head :ok }
    end
  end
end
