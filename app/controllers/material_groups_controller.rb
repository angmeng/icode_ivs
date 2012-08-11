class MaterialGroupsController < ApplicationController
  before_filter :authenticated_admin
  before_filter :set_locale
  # GET /material_groups
  # GET /material_groups.xml
  def index
    @material_groups = MaterialGroup.paginate(:page => params[:page], :per_page => 50, :order => "name")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @material_groups }
    end
  end

  # GET /material_groups/1
  # GET /material_groups/1.xml
  def show
    @material_group = MaterialGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @material_group }
    end
  end

  # GET /material_groups/new
  # GET /material_groups/new.xml
  def new
    @material_group = MaterialGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @material_group }
    end
  end

  # GET /material_groups/1/edit
  def edit
    @material_group = MaterialGroup.find(params[:id])
  end

  # POST /material_groups
  # POST /material_groups.xml
  def create
    @material_group = MaterialGroup.new(params[:material_group])

    respond_to do |format|
      if @material_group.save
        format.html { redirect_to(@material_group, :notice => 'MaterialGroup was successfully created.') }
        format.xml  { render :xml => @material_group, :status => :created, :location => @material_group }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @material_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /material_groups/1
  # PUT /material_groups/1.xml
  def update
    @material_group = MaterialGroup.find(params[:id])

    respond_to do |format|
      if @material_group.update_attributes(params[:material_group])
        format.html { redirect_to(@material_group, :notice => 'MaterialGroup was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @material_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /material_groups/1
  # DELETE /material_groups/1.xml
  def destroy
    @material_group = MaterialGroup.find(params[:id])
    @material_group.destroy

    respond_to do |format|
      format.html { redirect_back_or_default(material_groups_url) }
      format.xml  { head :ok }
    end
  end
end
