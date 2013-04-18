class GoodsReceiving

  def initialize(po)
  	@purchase_order = po
  	@items = []
  	@purchase_order.purchase_order_items.each do |poi|
  		delivered_qty = 0
  	  GoodsReceiveNoteItem.all(:conditions => ["purchase_order_item_id = ?", poi.id]).each do |grn_item|
  	  	delivered_qty += grn_item.deliver_quantity
  	  end
  		item = OpenStruct.new
  		item.product_id = poi.product_id
  		item.quantity   = poi.quantity
  		item.unit_price = poi.unit_price
  		item.project_id = poi.project_id
  		item.material_id = poi.material_id
  		item.currency_id = poi.currency_id
  		item.delivered_qty = delivered_qty
  	  item.pending_qty   = poi.quantity - delivered_qty
  		@items << item
  	end
  end

  def purchase_order
  	@purchase_order
  end

  def items
  	@items
  end

end