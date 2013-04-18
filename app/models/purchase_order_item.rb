class PurchaseOrderItem < ActiveRecord::Base
  belongs_to :purchase_order
  belongs_to :store_location
  belongs_to :product
  belongs_to :material
  belongs_to :project
  has_many   :goods_receive_note_items
  belongs_to :currency
  belongs_to :purchase_requisition_item
  #belongs_to :store_location
  #attr_accessible :purchase_invoice_id, :product_id, :quantity, :unit_price, :remark, :store_location_id
  attr_accessor :marked
  #after_save :increase_product_quantity
  #after_destroy :decrease_product_quantity
  
  def total_amount
    quantity * unit_price
  end

  def collected_quantity
    q = 0
    goods_receive_note_items.each do |i|
      q += i.deliver_quantity
    end
    q
  end
  
  
end
