class PurchaseOrder < ActiveRecord::Base
  belongs_to :supplier
  #belongs_to :company
  has_many :purchase_order_items
  has_many :purchase_requisition_items
  belongs_to :purchase_requisition
  has_many :goods_receive_notes
  has_one  :reserved_purchase_order
  belongs_to :project
  belongs_to :approved_user, :class_name => "User"
  belongs_to :purchased_user, :class_name => "User"
  belongs_to :currency

  #after_create :generate_order_number
  after_save   :check_reserved_po
  
  validates_presence_of(:purchase_order_date, :supplier_id)
  #validates_uniqueness_of :purchase_order_number
  
  delegate :code, :name, :address, :office_phone, :fax_number, :contact_person, :contact_number, :active, :remark, :to => :supplier, :prefix => true
  named_scope(:active, :conditions => "deleted = false")
  named_scope(:hidden, :conditions => "deleted = true")
  named_scope(:unsettled, :conditions => "deleted = false and settled = false")
  named_scope(:had_settled, :conditions => "deleted = false and settled = true")
  named_scope(:unimported, :conditions => "deleted = false and settled = false and imported = false")

  def mark_as_completed
    self.settled = true
    save!
  end

  def current_status
    settled ? "<em style='color:green'>Settled</em>" : "<em style='color:red'>Pending</em>"
  end
  
  def purchase_order_item_attributes=(purchase_order_item_attributes)
    purchase_order_item_attributes.each do |attributes|
      unless attributes[:quantity].blank? or attributes[:quantity].index(/[abcdefghijklmnopqrstuvwxyz]/) or attributes[:unit_price].blank? 
        purchase_order_items.build(attributes)
      end
    end
  end
  
  def add_order_items(items)
    name = items[:product_name]
    unless name.blank?
      combine = name.split("-")
      found_product = Product.find_by_code(combine[0])
      
      unless items[:quantity].blank? or items[:quantity].index(/[abcdefghijklmnopqrstuvwxyz]/) or found_product.nil?
       item = purchase_order_items.new
       item.product = found_product
       #item.unit_price = found_uom.cost
       item.quantity = items[:quantity]
       item.save!
      end
     end
  end
  
  def total_amount
    result = []

    purchase_order_items.each do |c|
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
    checked = false
    setting = Setting.first
    if purchase_order_number.eql?(setting.purchase_order_code + setting.purchase_order_last_number.to_s)
      #purchase_order_items.each do |c|
      #  c.destroy
      #end
      #destroy
      self.deleted = true
      save
      setting.purchase_order_last_number -= 1
      setting.save
      checked = true
    end
    checked
  end

  private

  def check_reserved_po
    found = ReservedPurchaseOrder.first(:conditions => ["purchase_order_number = ?", purchase_order_number])
    if found
      found.purchase_order_id = id
      found.used = true
      found.save!
    end
  end

#  def generate_order_number
#    setting = Setting.first
#    num = setting.purchase_order_last_number += 1
#    self.purchase_order_number = setting.purchase_order_code + num.to_s
#    setting.save!
#    save!
#  end
end
