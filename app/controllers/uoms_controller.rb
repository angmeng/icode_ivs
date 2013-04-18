class UomsController < ApplicationController
  before_filter :authenticated_admin
  before_filter :set_locale
  
  def index
    @uoms = Uom.paginate(:page => params[:page], :per_page => 50, :order => "name")

  end

  # GET /material_groups/1
  # GET /material_groups/1.xml
  def show
    @uom = Uom.find(params[:id])
  end

  # GET /material_groups/new
  # GET /material_groups/new.xml
  def new
    @uom = Uom.new

  end

  # GET /material_groups/1/edit
  def edit
    @uom = Uom.find(params[:id])
  end

  # POST /material_groups
  # POST /material_groups.xml
  def create
    @uom = Uom.new(params[:uom])

    respond_to do |format|
      if @uom.save
        format.html { redirect_to(@uom, :notice => 'Uom was successfully created.') }
        
      else
        format.html { render :action => "new" }
        
      end
    end
  end

  # PUT /material_groups/1
  # PUT /material_groups/1.xml
  def update
    @uom = Uom.find(params[:id])

    respond_to do |format|
      if @uom.update_attributes(params[:uom])
        format.html { redirect_to(@uom, :notice => 'Uom was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        
      end
    end
  end

  # DELETE /material_groups/1
  # DELETE /material_groups/1.xml
  def destroy
    @uom = Uom.find(params[:id])
    @uom.destroy

    respond_to do |format|
      format.html { redirect_back_or_default(uoms_url) }
      format.xml  { head :ok }
    end
  end
end
