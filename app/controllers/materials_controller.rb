class MaterialsController < ApplicationController
  before_filter :authenticated_admin_and_user
  before_filter :set_locale
  # GET /materials
  # GET /materials.xml
  def index
    @search = Material.search(params[:search])
    @materials = @search.all(:include => [:material_category, :material_group], :order => "material_categories.name, code").paginate(:page => params[:page], :per_page => 50)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @materials }
    end
  end

  # GET /materials/1
  # GET /materials/1.xml
  def show
    @material = Material.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @material }
    end
  end

  def show_options
    @materials = Material.all(:conditions => ['material_category = ?', params[:category_id].to_i])
    #@materials.each {|c|
    #   c.code = c.code_name
    #}
  end

  # GET /materials/new
  # GET /materials/new.xml
  def new
    if is_admin?
      @material = Material.new
    else
      flash[:error] = "You dont have access right"
      redirect_to materials_path
    end

  end

  def copy
     if is_admin?
       @material = Material.copy(params[:id])
     end
  end

  # GET /materials/1/edit
  def edit
    if is_admin?
      @material = Material.find(params[:id])
    else
      flash[:error] = "You dont have access right"
      redirect_to materials_path
    end
  end

  # POST /materials
  # POST /materials.xml
  def create
    @material = Material.new(params[:material])

    respond_to do |format|
      if @material.save
        format.html { redirect_to(@material, :notice => 'Material was successfully created.') }
        format.xml  { render :xml => @material, :status => :created, :location => @material }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @material.errors, :status => :unprocessable_entity }
      end
    end
  end



  # PUT /materials/1
  # PUT /materials/1.xml
  def update
    @material = Material.find(params[:id])

    respond_to do |format|
      if @material.update_attributes(params[:material])
        format.html { redirect_to(@material, :notice => 'Material was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @material.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /materials/1
  # DELETE /materials/1.xml
  def destroy
    if is_admin?
      @material = Material.find(params[:id])
      @material.destroy
    else
      flash[:error] = "You dont have access right"
      redirect_to materials_path
    end
    respond_to do |format|
      format.html { redirect_back_or_default(materials_url) }
      format.xml  { head :ok }
    end
  end
end
