class Currency < ActiveRecord::Base
  has_many :purchase_order_items
  has_many :purchase_requisition_items
  has_many :goods_receive_note_items
  has_many :purchase_requisitions
  has_many :purchase_orders

  before_create :check_position

  validates_presence_of :name
  validates_uniqueness_of :name

  attr_accessor :total

  private

  def check_position
    self.position = Currency.all.size.to_i
  end

end
