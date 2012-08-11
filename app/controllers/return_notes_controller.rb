class ReturnNotesController < ApplicationController
  before_filter :authenticated_admin_and_user
  before_filter :set_locale
  # GET /return_notes
  # GET /return_notes.xml
  def index

    @search = ReturnNote.search(params[:search])
    @return_notes = @search.all.uniq.paginate(:page => params[:page], :per_page => 50)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @return_notes }
    end
  end

  # GET /return_notes/1
  # GET /return_notes/1.xml
  def show
    @return_note = ReturnNote.find(params[:id])
    @items = @return_note.return_note_items
    initial_setup
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @return_note }
    end
  end

  # GET /return_notes/new
  # GET /return_notes/new.xml
  def new
    @return_note = ReturnNote.new
    initial_setup
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @return_note }
    end
  end

  # GET /return_notes/1/edit
  def edit
    @return_note = ReturnNote.find(params[:id])
    @suppliers = Supplier.options
  end

  # POST /return_notes
  # POST /return_notes.xml
  def create
    @return_note = ReturnNote.new(params[:return_note])

    respond_to do |format|
      if @return_note.save
        if @return_note.import_items(params[:item])
          flash[:notice] = (t "flashes.successfully_created")
        else
          flash[:error] = "You have invalid item to add into the PR"
        end
        format.html { redirect_to(@return_note) }
        format.xml  { render :xml => @return_note, :status => :created, :location => @return_note }
      else
        format.html {
          initial_setup
          render :action => "new" }
        format.xml  { render :xml => @return_note.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /return_notes/1
  # PUT /return_notes/1.xml
  def update
    @return_note = ReturnNote.find(params[:id])

    respond_to do |format|
      if @return_note.update_attributes(params[:return_note])
        format.html { redirect_to(@return_note, :notice => 'ReturnNote was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @return_note.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /return_notes/1
  # DELETE /return_notes/1.xml
  def destroy
    @return_note = ReturnNote.find(params[:id])
    @return_note.void = true
    @return_note.save!
    respond_to do |format|
      format.html { redirect_back_or_default(return_notes_url) }
      format.xml  { head :ok }
    end
  end

  def search_by_category
    materials = Material.all(:conditions => ["material_category_id = ?", params[:id].to_i], :order => "description")
    p = Material.new(:code => "None")
    p.id = 0
    materials.insert(0, p)
    @materials = materials.map {|c| [c.code_name, c.id]}
    render :update do |page|
      page.replace_html 'material', :partial => 'material', :locals => {:materials => @materials}
    end
  end

  def add_items
    @return_note = ReturnNote.find(params[:id])
    if @return_note.import_items(params[:item])
      flash[:notice] = (t "flashes.successfully_updated")
    else
      flash[:error] = "You have invalid item to add into Return Note"
    end
    redirect_to @return_note
  end

  def update_items
    @return_note = ReturnNote.find(params[:id])
    params[:item] ||= []
    params[:item].each do |item_id, content|
      found = @return_note.return_note_items.find(item_id.to_i)
      found.quantity = content[:quantity].to_i
      found.remark = content[:remark]
      found.save!
    end

    flash[:notice] = "Operation Completed"
    redirect_to(@return_note)

  end

  def remove_item
    item = ReturnNoteItem.find(params[:id])
    @return_note = item.return_note
    item.destroy
    flash[:notice] = "Operation Completed"
    redirect_to @return_note
  end

  def preview
    @return_note = ReturnNote.find(params[:id])
    @items = @return_note.return_note_items.all
    render :layout => false
  end

  private

  def initial_setup
    @products = Product.options
    @projects = Project.options
    @categories = MaterialCategory.options
    @suppliers = Supplier.options
    @materials = []
  end
end
