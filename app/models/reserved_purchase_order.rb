class ReservedPurchaseOrder < ActiveRecord::Base
  belongs_to :purchase_order
  validates_presence_of   :purchase_order_number
  validates_uniqueness_of :purchase_order_number
  
  
  

  def generate_order_number
    transaction do
      setting = Setting.first
      num = setting.purchase_order_last_number += 1
      self.purchase_order_number = setting.purchase_order_code + num.to_s
      setting.save!
      save!
    end
  end
end
