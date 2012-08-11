class PurchaseRequisitionsController < ApplicationController
  before_filter :authenticated_admin_and_user
  before_filter :set_locale
  before_filter :find_pr, :except => [:update_remark, :edit_remark, :remove_item, :index, :new, :create, :search_by_category, :search_by_material, :replace_material_id]

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
   
  def index
    @search = PurchaseRequisition.search(params[:search])
    @prs = @search.all(:order => "pr_date DESC, pr_number").uniq.paginate(:page => params[:page], :per_page => 30)
  end
  
  def show
    initial_setup
    @current_items = @pr.purchase_requisition_items.all(:joins => [:supplier, {:material => [:uom, :material_category]}, :purchase_requisition, :product], :order =>  "sequence_number")#.paginate(:page => params[:page], :per_page => 20)
  end
  
  def new
    @pr = PurchaseRequisition.new
    initial_setup
  end

  def search_by_category
    materials = Material.all(:conditions => ["material_category_id = ?", params[:id].to_i], :order => "code")
    p = Material.new(:code => "None")
    p.id = 0
    materials.insert(0, p)
    @materials = materials.map {|c| [c.code_name, c.id]}
    render :update do |page|
      page.replace_html 'material', :partial => 'material', :locals => {:materials => @materials}
    end
  end

  def search_by_material
    @history = PurchaseOrderItem.all(:conditions => ["material_id = ?", params[:id].to_i], :joins => [{:purchase_order => [:supplier]}], :order => "purchase_order_date DESC")
    render :update do |page|
      page.replace_html 'history', :partial => 'history', :locals => {:history => @history}
    end
  end
  
  def create
    @pr = PurchaseRequisition.new(params[:purchase_requisition])
    if @pr.save
      if @pr.import_items(params[:item])
        flash[:notice] = (t "flashes.successfully_created")
      else
        flash[:error] = "You have invalid item to add into the PR"
      end
      redirect_to @pr
    else
      initial_setup
      render :action => 'new'
    end
  end
  
  def add_items
    if @pr.import_items(params[:item])
      flash[:notice] = (t "flashes.successfully_updated")
      session[:product_id] = params[:item][:product_id]
      session[:supplier_id] = params[:item][:supplier_id]
    else
      flash[:error] = "You have invalid item to add into PR"
    end
    redirect_to @pr
  end

  def remove_item
    item = PurchaseRequisitionItem.find(params[:id])
    pr = item.purchase_requisition
    item.destroy
    flash[:notice] = "Item has been destroy"
    redirect_to pr
  end
  
  def edit
    @suppliers = Supplier.all(:order => "name")
    @projects = Project.options
  end
  
  def update
    if @pr.update_attributes(params[:purchase_requisition])
      flash[:notice] = "Purchase Requisition updated"
      redirect_to @pr
    else
      render :action => 'edit'
    end
  end

  def send_for_approval
    @pr.send_for_approval
    flash[:notice] = "PR sent"
    redirect_to @pr
  end

  def approve
    if @pr.approve
      @pr.generate_po
      flash[:notice] = "PR approved and PO generated"
    else
      flash[:error] = "You dont have any confirmed item or invalid PR information"
    end
    
    redirect_to @pr
  end

  def generate
    @pr.generate_po
    flash[:notice] = "Related PO generated"
    redirect_to @pr
  end

  def regenerate
    @pr.regenerate_po
    flash[:notice] = "PO regenerated"
    redirect_to @pr
  end
  
  def void
    @pr.void = true
    @pr.save
    flash[:notice] = (t "flashes.successfully_voided")
    redirect_back_or_default purchase_requisitions_url
  end
  
  def destroy
    if @pr.verify_for_destroy
      flash[:notice] = (t "flashes.successfully_destroyed")
    else
      flash[:error] = (t "flashes.cannot_destroy_pls_use_void")
    end
    redirect_back_or_default(purchase_requisitions_url)
  end
  
  def edit_items
    params[:item] ||= []
    if params[:commit] == "Remove Selected"
      params[:item].each do |item_id, content|
        found = @pr.purchase_requisition_items.find(item_id.to_i)
        found.destroy if found if content[:selected].to_i == 1

      end
    elsif params[:commit] == "Confirm"
      
      @pr.purchase_requisition_items.each do |c|
        c.confirmed = false
        c.save!
      end
      params[:item].each do |item_id, content|
        found = @pr.purchase_requisition_items.find(item_id.to_i)
        if found
          found.confirmed = true
          found.save!
        end
      end
    elsif params[:commit] == "Update"
      params[:item].each do |item_id, content|
        found = @pr.purchase_requisition_items.find(item_id.to_i)
        if found
          found.unit_price = content[:unit_price].to_f
          found.quantity = content[:quantity].to_f
          found.stock_quantity = content[:stock_quantity].to_f
          found.purchase_quantity = content[:purchase_quantity].to_f
          found.sequence_number = content[:sequence_number].to_i unless content[:sequence_number].blank?
          found.save!
          po_item = found.purchase_order_item rescue false
          if po_item
            po_item.quantity = found.quantity
            po_item.unit_price = found.unit_price
            po_item.save!
            grn_item = po_item.goods_receive_note_item rescue false
            if grn_item
              grn_item.quantity = found.quantity
              grn_item.save!
            end
          end

        end
      end
    end
    flash[:notice] = "Operation Completed"
    redirect_to(@pr)
    
  end
  
  def preview
    @number_rows = params[:number_rows].blank? ?  18 : params[:number_rows].to_i
    @items = @pr.purchase_requisition_items.all(:conditions => ["confirmed = true"], :order => "sequence_number")
    @currency = @pr.currency
    render :layout => false
  end

  def edit_remark
    @item = PurchaseRequisitionItem.find(params[:id])
    @pr = @item.purchase_requisition
  end

  def update_remark
    @pr = PurchaseRequisition.find(params[:id])
    params[:item].each do |item_id, content|
      item = @pr.purchase_requisition_items.find(item_id.to_i)
      item.remark = content[:remark]
      item.save!
    end
    flash[:notice] = "Update Completed"
    redirect_to @pr
  end

  def update_po
    @pr = PurchaseRequisition.find(params[:id])
    params[:po].each do |po_id, content|
      item = @pr.purchase_orders.find(po_id.to_i)
      item.purchase_order_number = content[:po_number]
      item.save!
    end
    flash[:notice] = "PO No Update Completed"
    redirect_to @pr
  end


  private

  def find_pr
    @pr = PurchaseRequisition.find(params[:id])
  end

  def initial_setup
    @products = Product.options
    @projects = Project.options
    @categories = MaterialCategory.options
    @suppliers = Supplier.options
    @currency = Currency.all(:order => "position, name").map { |c| [c.name, c.id] }
    @materials = []
  end
  
end
