class GoodsReceiveNote < ActiveRecord::Base
  has_many :goods_receive_note_items
  belongs_to :supplier
  belongs_to :purchase_order

  after_create :setup
  before_create :assign_supplier
  validates_presence_of(:purchase_order_id, :do_number)
  
  #delegate :code, :name, :address, :office_phone, :fax_number, :contact_person, :contact_number, :active, :remark, :to => :supplier, :prefix => true
  named_scope(:unsettled, :conditions => "settled = false")
  
  def total_amount
    total = 0.0
    goods_receive_note_items.each do |c|
      total += c.total_amount
    end
    total
  end

  def status
    if void?
      "<em style='color:red'>Voided</em>"
    else
      if settled?
        "<em style='color:green'>Completed</em>"
      else
        "<em style='color:blue'>Processing</em>"
      end
    end
  end

  def verify_settle
    checked = true
    goods_receive_note_items.each do |i|
      checked = false unless i.full_deliver?
    end
    if checked
      self.settled = true
      save!
    end
    checked
  end

  def unsettle
    self.settled = false
    save!
  end
  
  def verify_destroy
    self.void = true
    p = purchase_order
    p.imported = false
    p.save
    goods_receive_note_items.destroy_all
    save!
  end

  def update_items(item)
    item.each do |item_id, content|
      i = goods_receive_note_items.find(item_id)
      i.unit_price = content[:unit_price].to_f rescue i.unit_price
      i.store_location_id = content[:store_location_id].to_i
      #i.remark = content[:remark]
      i.deliver_quantity = content[:deliver_quantity]
      i.save!
    end
  end

  def import_items(item)
    item.each do |item_id, content|
      if content[:selected].to_i == 1
        po_item = PurchaseOrderItem.find(item_id.to_i)
        g = goods_receive_note_items.new
        g.product_id = po_item.product_id
        g.material_id = po_item.material_id
        g.project_id = po_item.project_id
        g.purchase_order_item_id = po_item.id
        g.currency_id = po_item.currency_id
        g.quantity = po_item.quantity
        g.save!
      end unless goods_receive_note_items.first(:conditions => ["purchase_order_item_id = ?", item_id.to_i])
    end
  end

  private

  def setup
    generate_number
  end

  def generate_number
    setting = Setting.first
    num = setting.grn_last_number += 1
    self.grn_number = setting.grn_code + num.to_s
    #setting.grn_last_number = num
    setting.save!
    save!
  end

  def assign_supplier
    self.supplier_id = purchase_order.supplier_id
  end

end
