class GoodsReceiveNoteItem < ActiveRecord::Base
  belongs_to :goods_receive_note
  belongs_to :purchase_order_item
  belongs_to :material
  belongs_to :product
  belongs_to :project
  belongs_to :store_location
  belongs_to :currency

  attr_accessor :marked

  def balance
    
  end

  def full_deliver?
    quantity >= deliver_quantity
  end

end
