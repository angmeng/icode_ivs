class PurchaseRequisition < ActiveRecord::Base

  belongs_to :company
  has_many   :purchase_requisition_items
  has_many   :confirmed_items, :conditions => "confirmed = true", :class_name => "PurchaseRequisitionItem"
  belongs_to :purchase_requisition_category
  has_many   :purchase_orders
  belongs_to :issued_user, :class_name => "User"
  belongs_to :approved_user, :class_name => "User"
  belongs_to :project
  belongs_to :currency
  #attr_accessible :company_id, :invoice_date, :invoice_number, :supplier_id, :remark, :void, :purchase_invoice_item_attributes
  
  validates_presence_of(:pr_date, :purchase_requisition_category_id, :project_id)
  validates_inclusion_of :purchase_requisition_category_id, :in => 1..99, :message => "You must select the purchase category"
  validates_uniqueness_of :pr_number
  delegate :code, :name, :address, :office_phone, :fax_number, :contact_person, :contact_number, :active, :remark, :to => :supplier, :prefix => true
  named_scope(:active, :conditions => "deleted = false")
  named_scope(:hidden, :conditions => "deleted = true")

  after_create :generate_order_number

  PROCESSING = 0
  WAITING_FOR_APPROVAL = 1
  APPROVED = 2

  def is_processing?
    status_id == PROCESSING
  end

  def waiting_for_approval?
    status_id == WAITING_FOR_APPROVAL
  end

  def approved?
    status_id == APPROVED
  end

  def status
    if void
      "<em style='color:red'>Voided</em>"
    else
      case status_id
      when PROCESSING
        "<em style='color:blue'>Processing</em>"
      when WAITING_FOR_APPROVAL
        "<em style='color:orange'>Waiting for Approval</em>"
      when APPROVED
        "<em style='color:green'>Approved</em>"
      else
        "<em style='color:red'>Unknown</em>"
      end
    end
  end

  def import_items(item)
    unless item[:quantity].index(/[abcdefghijklmnopqrstuvwxyz]/) or item[:unit_price].index(/[abcdefghijklmnopqrstuvwxyz]/) or item[:material_id].blank? or item[:supplier_id].blank? or item[:quantity].blank? or item[:unit_price].blank?
      total = purchase_requisition_items.size + 1
      purchase_requisition_items.create!(:sequence_number => total, :product_id => item[:product_id], :material_id => item[:material_id], :supplier_id => item[:supplier_id], :quantity => item[:quantity], :purchase_quantity => item[:quantity], :unit_price => item[:unit_price], :remark => item[:remark], :currency_id => item[:currency_id])
    else
      return false
    end
  end

  def send_for_approval
    self.status_id = WAITING_FOR_APPROVAL
    save!
  end

  def approve
    if confirmed_items.empty?
      return false
    else
      self.status_id = APPROVED
      save!
    end
    
  end

  def generate_po
    prepare_suppliers
    generate_po_for_suppliers
  end

  def regenerate_po
    prepare_suppliers
    regenerate_po_for_suppliers
    
  end
  
  def total_amount
    result = []
    
    purchase_requisition_items.all(:conditions => "confirmed = true").each do |c|
      found = false
      result.each do |r|
        if r.id == c.currency_id
          r.total += c.total_amount
          found = true
        end
      end
      unless found
        new_item = c.currency
        new_item.total = c.total_amount
        result << new_item
      end
    end
    result
  end
  
  def verify_for_destroy
    self.void = true
    self.deleted = true
    save!
  end

  private

  def generate_order_number
    #setting = Setting.first
    #num = setting.purchase_requisition_last_number += 1
    #self.pr_number = setting.purchase_requisition_code + num.to_s

    #setting.save!
    #save!
  end

  def prepare_suppliers
    @result = []
    purchase_requisition_items.all(:conditions => "confirmed = true").each do |item|
      found = false
      @result.each do |s|
        if s.id == item.supplier_id
          found = true
          s.prepared_requisition_items << item
        end
      end
      unless found
        s = item.supplier
        s.prepared_requisition_items = []
        s.prepared_requisition_items << item
        @result << s
      end
    end
  end

  def generate_po_for_suppliers
    @result.each do |r|
      po = purchase_orders.first(:conditions => ["supplier_id = ?", r.id])
      po = purchase_orders.create!(:approved_user_id => approved_user_id, :purchased_user_id => issued_user_id,:project_id => project_id, :supplier_id => r.id, :purchase_order_date => Date.today, :term => r.term, :delivery_date => delivery_date, :expected_delivery_date => expected_delivery_date) unless po
      r.prepared_requisition_items.each do |item|
        po_item = po.purchase_order_items.new
        po_item.product_id = item.product_id
        po_item.project_id = project_id
        po_item.material_id = item.material_id
        po_item.remark = item.remark
        po_item.unit_price = item.unit_price
        po_item.quantity = item.purchase_quantity
        po_item.currency_id = item.currency_id
        po_item.purchase_requisition_item_id = item.id
        po_item.save!
        item.purchase_order_id = po.id
        item.save!
      end
    end
  end

   def regenerate_po_for_suppliers
     po_items_ids = []
     g_items_ids = []
     @result.each do |r|
      po = purchase_orders.first(:conditions => ["supplier_id = ?", r.id])
      po = purchase_orders.create!(:approved_user_id => approved_user_id, :purchased_user_id => issued_user_id, :project_id => project_id,:supplier_id => r.id, :purchase_order_date => Date.today, :term => r.term, :delivery_date => delivery_date, :expected_delivery_date => expected_delivery_date) unless po
      
      r.prepared_requisition_items.each do |item|
        po_item = item.purchase_order_item
        po_item = po.purchase_order_items.new unless po_item
        po_item.product_id = item.product_id
        po_item.project_id = project_id
        po_item.material_id = item.material_id
        po_item.remark = item.remark
        po_item.unit_price = item.unit_price
        po_item.quantity = item.purchase_quantity
        po_item.currency_id = item.currency_id
        po_item.purchase_requisition_item_id = item.id
        po_item.save!
        po_items_ids << po_item.id
        item.purchase_order_id = po.id
        item.save!
        po.goods_receive_notes.each do |g|
          g.goods_receive_note_items.all(:conditions => ["purchase_order_item_id = ?", po_item.id]).each do |g_item|
            g_item.currency_id = po_item.currency_id
            g_item.project_id = po_item.project_id
            g_item.product_id = po_item.product_id
            g_item.material_id = po_item.material_id
            g_item.purchase_order_item_id = po_item.id
            g_item.quantity = po_item.quantity
            g_item.save!
            g_items_ids << g_item.id
          end
        end
      end
    end

    purchase_orders.each do |po|
      po.purchase_order_items.each do |item|
        item.destroy unless po_items_ids.include?(item.id)
      end
      po.goods_receive_notes.each do |grn|
        grn.goods_receive_note_items.each do |gi|
          gi.destroy unless g_items_ids.include?(gi.id)
        end
      end
    end
  end

end
