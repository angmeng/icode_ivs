class Uom < ActiveRecord::Base
  has_many :purchase_order_items
  has_many :invoice_items
  has_many :products
  has_many :materials
  validates_presence_of(:name)
  validates_uniqueness_of :name
  
  
end
