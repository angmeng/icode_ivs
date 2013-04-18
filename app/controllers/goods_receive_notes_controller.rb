class GoodsReceiveNotesController < ApplicationController
  before_filter :authenticated_admin_and_user
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
   
  # GET /outlet_goods_receive_notes
  # GET /outlet_goods_receive_notes.xml
  def index
    @search = GoodsReceiveNote.search(params[:search])
    @goods_receive_notes = @search.all(:joins => [:purchase_order], :order => "grn_date DESC, grn_number").uniq.paginate(:page => params[:page], :per_page => 50)
  end

  # GET /outlet_goods_receive_notes/1
  # GET /outlet_goods_receive_notes/1.xml
  def show
    @goods_receive_note = GoodsReceiveNote.find(params[:id])
    @items = @goods_receive_note.goods_receive_note_items.paginate(:page => params[:page], :per_page => 20)
  end

  # GET /outlet_goods_receive_notes/new
  # GET /outlet_goods_receive_notes/new.xml
  def new
    @goods_receive_note = GoodsReceiveNote.new
    #@po = PurchaseOrder.unimported
    @suppliers =  Supplier.store_options
    @po = []
  end

  # GET /outlet_goods_receive_notes/1/edit
  def edit
    @goods_receive_note = GoodsReceiveNote.find(params[:id])
    if @goods_receive_note.settled? or @goods_receive_note.void?
      flash[:error] = "GRN has been closed for editing"
      redirect_to goods_receive_notes_url
    end
    
  end

  # POST /outlet_goods_receive_notes
  # POST /outlet_goods_receive_notes.xml
  def create
    @goods_receive_note = GoodsReceiveNote.new(params[:goods_receive_note])
    if params[:commit] == "Search by PO No"
      @po = PurchaseOrder.all(:conditions => ["purchase_order_number = ?", params[:po_number]])
      @suppliers =  Supplier.options
      render :action => "new"
    elsif params[:commit] == "Search by Supplier"
      @po = PurchaseOrder.all(:conditions => ["supplier_id = ?", params[:supplier_id]])
      @suppliers =  Supplier.options
      render :action => "new"
    else
      if params[:goods_receive_note] && params[:goods_receive_note][:purchase_order_id]
        @purchase_order = PurchaseOrder.find(params[:goods_receive_note][:purchase_order_id].to_i)
        @items = @purchase_order.purchase_order_items
        render :action => "new"
      else
        @goods_receive_note.purchase_order_id = params[:purchase_order_id].to_i
        if @goods_receive_note.save
          @goods_receive_note.import_items(params[:purchase_order_item] ||= [])
          flash[:notice] = 'GoodsReceiveNote was successfully created.'
          redirect_to(@goods_receive_note)
        else
          @purchase_order = PurchaseOrder.find(params[:purchase_order_id].to_i)
          @items = @purchase_order.purchase_order_items
          render :action => "new"
        end
      end
    end
  end

  # PUT /outlet_goods_receive_notes/1
  # PUT /outlet_goods_receive_notes/1.xml
  def update
    @goods_receive_note = GoodsReceiveNote.find(params[:id])

    respond_to do |format|
      if @goods_receive_note.update_attributes(params[:goods_receive_note])
        flash[:notice] = 'GoodsReceiveNote was successfully updated.'
        format.html { redirect_to(@goods_receive_note) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @goods_receive_note.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update_items
    @goods_receive_note = GoodsReceiveNote.find(params[:id])
    params[:item] ||= []
    @goods_receive_note.update_items(params[:item])
    flash[:notice] = "Update Completed"
    redirect_to @goods_receive_note
  end

  def settle
    @goods_receive_note = GoodsReceiveNote.find(params[:id])
    if params[:status_id].to_i == 1
      if @goods_receive_note.verify_settle
        flash[:notice] = "GRN settled"
      else
        flash[:error] = "Items delivered quantity is invalid"
      end
    elsif params[:status_id].to_i == 2
      @goods_receive_note.settled = false
      @goods_receive_note.save!
    end
    redirect_to @goods_receive_note
  end

  def remove_item
    item = GoodsReceiveNoteItem.find(params[:id])
    @goods_receive_note = item.goods_receive_note
    item.destroy
    flash[:notice] = "Operation Completed"
    redirect_to @goods_receive_note
  end

  # DELETE /outlet_goods_receive_notes/1
  # DELETE /outlet_goods_receive_notes/1.xml
  def destroy
    @goods_receive_note = GoodsReceiveNote.find(params[:id])
    if @goods_receive_note.void?
      flash[:error] = "GRN has already been voided before"
    else
      @goods_receive_note.verify_destroy
    end
    
    respond_to do |format|
      format.html { redirect_back_or_default(goods_receive_notes_url) }
      format.xml  { head :ok }
    end
  end

  def show_items
    @goods_receive_note = GoodsReceiveNote.find(params[:id])
    @purchase_order = @goods_receive_note.purchase_order
    @items = @purchase_order.purchase_order_items
  end
  
  def import_items
    @goods_receive_note = GoodsReceiveNote.find(params[:id])
    @goods_receive_note.import_items(params[:purchase_order_item] ||= [])
    flash[:notice] = "Operation Completed"
    redirect_to @goods_receive_note
  end

  def settle_po
    @goods_receive_note = GoodsReceiveNote.find(params[:id])
    po = @goods_receive_note.purchase_order
    po.imported = true
    po.save!
    flash[:notice] = "Operation Completed"
    redirect_to @goods_receive_note
  end

  def unsettle_po
    @goods_receive_note = GoodsReceiveNote.find(params[:id])
    po = @goods_receive_note.purchase_order
    po.imported = false
    po.save!
    flash[:notice] = "Operation Completed"
    redirect_to @goods_receive_note
  end

  def unsettled
    @goods_receive_notes = GoodsReceiveNote.unsettled.paginate(:page => params[:page], :per_page => 50)
  end

  def edit_remark
    @item = GoodsReceiveNoteItem.find(params[:id])
    @goods_receive_note = @item.goods_receive_note
  end

  def update_remark
    @goods_receive_note = GoodsReceiveNote.find(params[:id])
    params[:item].each do |item_id, content|
      item = @goods_receive_note.goods_receive_note_items.find(item_id.to_i)
      item.remark = content[:remark]
      item.save!
    end
    flash[:notice] = "Update Completed"
    redirect_to @goods_receive_note
  end

end
